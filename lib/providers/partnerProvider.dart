// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:lingkung_businessPartner/models/businessDataModel.dart';
// //models
// import 'package:lingkung_businessPartner/models/businessPartnerModel.dart';
// //services
// import 'package:lingkung_businessPartner/services/businessPartnerService.dart';

// enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

// class PartnerProvider with ChangeNotifier{
//   FirebaseAuth _auth;
//   FirebaseUser _businessPartner;
//   Firestore _firestore = Firestore.instance;
//   Status _status = Status.Uninitialized;
//   PartnerServices _businessPartnerService = PartnerServices();
//   // OrderServices _orderServices = OrderServices();
//   PartnerModel _businessPartnerModel;
//   BusinessDataModel _businessDataModel;

//   // getter
//   FirebaseUser get businessPartner => _businessPartner;
//   PartnerModel get businessPartnerModel => _businessPartnerModel;
//   BusinessDataModel get businessDataModel => _businessDataModel;
//   Status get status => _status;

//   // public variables
//   // List<OrderModel> orders = [];

//   final formkey = GlobalKey<FormState>();
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController name = TextEditingController();
//   TextEditingController nomorhp = TextEditingController();

//   PartnerProvider.initialize(): _auth = FirebaseAuth.instance{
//     _auth.onAuthStateChanged.listen(_onStateChanged);
//   }

//   // Login email & pass
//     Future<bool> login() async {
//     try{
//       _status = Status.Authenticating;
//       notifyListeners();
//       await _auth.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
//       return true;
//     } catch (e) {
//       _status = Status.Unauthenticated;
//       notifyListeners();
//       print(e.toString());
//       return false;
//     }
//   }

//   // Register email & pass
//   Future<bool> register() async {
//     try{
//       _status = Status.Authenticating;
//       notifyListeners();
//       await _auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((result){
//         _firestore.collection('businessPartners').document(result.user.uid).setData({
//           'uid':result.user.uid,
//           'name':name.text,
//           'nomorHP': int.parse(nomorhp.text),
//           'email': email.text,
//           // 'businessId': businessDataModel.id
//         });
//       });
//       return true;
//     } catch (e) {
//       _status = Status.Unauthenticated;
//       notifyListeners();
//       print(e.toString());
//       return false;
//     }
//   }

//   // Logout
//   Future logout() async {
//     try {
//       _status = Status.Unauthenticated;
//       notifyListeners();
//       await _auth.signOut();
//       return true;
//     } catch (e) {
//       _status = Status.Authenticating;
//       notifyListeners();
//       print(e.toString());
//       return false;
//     }
//   }

//   void clearController(){
//     name.text = "";
//     password.text = "";
//     email.text = "";
//   }

//   Future<void> reloadPartnerModel() async {
//     _businessPartnerModel = await _businessPartnerService.getPartnerById(businessPartner.uid);
//     notifyListeners();
//   }

//   // Future<void> reloadBusinessDataModel() async {
//   //   _businessPartnerModel = await _businessPartnerService.getBusinessDataById(businessDataModel.id);
//   //   notifyListeners();
//   // }

//   Future<void> _onStateChanged(FirebaseUser firebasePartner) async {
//     if (firebasePartner == null) {
//       _status = Status.Unauthenticated;
//     } else {
//       _businessPartner = firebasePartner;
//       _status = Status.Authenticated;
//       _businessPartnerModel = await _businessPartnerService.getPartnerById(businessPartner.uid);
//     }
//     notifyListeners();
//   }

// //   Future<bool> addToCard({ProductModel product, int quantity})async{
// //     print("THE PRODUC IS: ${product.toString()}");
// //     print("THE qty IS: ${quantity.toString()}");

// //     try{
// //       var uuid = Uuid();
// //       String cartItemId = uuid.v4();
// //       List cart = _businessPartnerModel.cart;
// // //      bool itemExists = false;
// //       Map cartItem ={
// //         "id": cartItemId,
// //         "name": product.name,
// //         "image": product.image,
// //         "productId": product.id,
// //         "price": product.price,
// //         "quantity": quantity
// //       };

// // //      for(Map item in cart){
// // //        if(item["productId"] == cartItem["productId"]){
// // ////          call increment quantity
// // //          itemExists = true;
// // //          break;
// // //        }
// // //      }

// // //      if(!itemExists){
// //         print("CART ITEMS ARE: ${cart.toString()}");
// //         _businessPartnerService.addToCart(businessPartnerId: _businessPartner.uid, cartItem: cartItem);
// // //      }

// //       return true;
// //     }catch(e){
// //       print("THE ERROR ${e.toString()}");
// //       return false;
// //     }

// //   }

//   // getOrders()async{
//   //   orders = await _orderService.getPartnerOrders(businessPartnerId: _businessPartner.uid);
//   //   notifyListeners();
//   // }

//   // Future<bool> removeFromCart({Map cartItem})async{
//   //   print("THE PRODUC IS: ${cartItem.toString()}");

//   //   try{
//   //     _businessPartnerService.removeFromCart(businessPartnerId: _businessPartner.uid, cartItem: cartItem);
//   //     return true;
//   //   }catch(e){
//   //     print("THE ERROR ${e.toString()}");
//   //     return false;
//   //   }
//   // }

// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_partner/models/trashReceiveModel.dart';
//models
import 'package:lingkung_partner/models/partnerModel.dart';
//services
import 'package:lingkung_partner/services/partnerService.dart';

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
          'phoneNumber': phoNumber.text,
          'email': email.text,
          'image': '',
          'address': address.text,
          "trashReceive": [],
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

  // getBusinessData() async {
  //   businessDatas = await _businessDataService.getBusinessDataByPartner(partnerId: _businessPartner.uid);
  //   notifyListeners();
  // }

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
}
