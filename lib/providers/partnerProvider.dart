import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_partner/models/addressModel.dart';
import 'package:lingkung_partner/models/trashReceiveModel.dart';
//models
import 'package:lingkung_partner/models/partnerModel.dart';
//services
import 'package:lingkung_partner/services/partnerService.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated, Registering }

class PartnerProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _businessPartner;
  Firestore _firestore = Firestore.instance;
  Status _status = Status.Uninitialized;
  PartnerServices _businessPartnerService = PartnerServices();
  PartnerModel _businessPartnerModel;

  // getter
  FirebaseUser get businessPartner => _businessPartner;
  PartnerModel get businessPartnerModel => _businessPartnerModel;
  Status get status => _status;

  // public variables
  List<TrashReceiveModel> trashReceives = [];

  final formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phoNumber = TextEditingController();
  TextEditingController address = TextEditingController();

  PartnerProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  // Login email & pass
  Future<bool> login() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  // Register email & pass
  Future<bool> register() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firestore
            .collection('businessPartners')
            .document(result.user.uid)
            .setData({
          'uid': result.user.uid,
          'name': name.text,
          'phoneNumber': int.parse(phoNumber.text),
          'email': email.text,
          'image': '',
          'address': address.text,
          'balance': '',
          'customer': '',
          'weight': '',
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  // Logout
  Future logout() async {
    try {
      _status = Status.Unauthenticated;
      notifyListeners();
      await _auth.signOut();
      return true;
    } catch (e) {
      _status = Status.Authenticating;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  void clearController() {
    name.text = "";
    phoNumber.text = "";
    address.text = "";
    email.text = "";
    password.text = "";
  }

  Future<void> reloadPartnerModel() async {
    _businessPartnerModel =
        await _businessPartnerService.getPartnerById(businessPartner.uid);
    notifyListeners();
  }

  Future<void> _onStateChanged(FirebaseUser firebasePartner) async {
    if (firebasePartner == null) {
      _status = Status.Unauthenticated;
    } else {
      _businessPartner = firebasePartner;
      _status = Status.Authenticated;
      _businessPartnerModel =
          await _businessPartnerService.getPartnerById(businessPartner.uid);
    }
    notifyListeners();
  }

  Future<bool> addAddress(
      {String locationBenchmarks,
      String addressDetail,
      String latMaps,
      String longMaps}) async {
    print("Location On Maps: ${latMaps.toString()}, ${longMaps.toString()}");

    try {
      var uuid = Uuid();
      String addressId = uuid.v4();
      AddressModel addressList = _businessPartnerModel.addressModel;
      Map addressModel = {
        "id": addressId,
        "locationBenchmarks": locationBenchmarks,
        "addressDetail": addressDetail,
        "latitude": latMaps,
        "longitude": longMaps
      };

      AddressModel address = AddressModel.fromMap(addressModel);
      print("ADDRESS ARE: ${addressList.toString()}");
      _businessPartnerService.addAddress(userId: _businessPartner.uid, addressModel: address);
      notifyListeners();
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      notifyListeners();
      return false;
    }
  }
}
