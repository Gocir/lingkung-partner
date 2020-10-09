import 'dart:async';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
//models
import 'package:lingkung_partner/models/addressModel.dart';
import 'package:lingkung_partner/models/bankAccountModel.dart';
import 'package:lingkung_partner/models/ownerDataModel.dart';
import 'package:lingkung_partner/models/operationalTimeModel.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/models/trashReceiveModel.dart';
//screens
import 'package:lingkung_partner/main.dart';
import 'package:lingkung_partner/screens/authenticate/verificationCode.dart';
import 'package:lingkung_partner/screens/profileDetail/businessName.dart';
import 'package:lingkung_partner/screens/profileDetail/dataVerification.dart';
import 'package:lingkung_partner/screens/profileDetail/dataActivation.dart';
import 'package:lingkung_partner/screens/profileDetail/accountStatus.dart';
//services
import 'package:lingkung_partner/services/partnerService.dart';
//utilities
import 'package:lingkung_partner/utilities/navigator.dart';

enum Status {
  Uninitialized,
  Unauthenticated,
  Authenticated,
  Authenticating,
  Registering,
  Registered,
  Verify,
  Activate
}
//  Unitialized: Memeriksa apakah pengguna masuk atau tidak. Dalam keadaan ini, kami akan menampilkan Loading.
//  Unauthenticated: Dalam Status ini, kami akan menampilkan halaman authenticate untuk memasukkan kredensial.
//  Authenticating: Pengguna telah menekan tombol masuk dan kami mengautentikasi pengguna. Dalam Status ini, kami akan menampilkan bilah Kemajuan.
//  Authenticated: Pengguna diautentikasi. Dalam Status ini, kami akan menampilkan beranda.

class PartnerProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _businessPartner;
  Status _status = Status.Uninitialized;
  PartnerServices _businessPartnerService = PartnerServices();
  PartnerModel _businessPartnerModel;

  // getter
  FirebaseUser get businessPartner => _businessPartner;
  PartnerModel get businessPartnerModel => _businessPartnerModel;
  Status get status => _status;

  // public variables
  List<TrashReceiveModel> trashReceives = [];
  List<PartnerModel> partnerByPhone = [];

  final scaffoldStatekey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phoNumberLogin = TextEditingController();

  String smsCode;
  String verificationId;
  String errorMessage;
  String name;
  String mail;
  bool loading = false;

  PartnerProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  //  Code Sent
  Future<void> verify(BuildContext context, String phoneNumber, String userName,
      String email) async {
    name = userName;
    mail = email;
    final PhoneCodeSent codeSent = (String verifId, [int forceCodeResend]) {
      this.verificationId = verifId;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => VerificationCode()));
    };

    final PhoneVerificationCompleted verified =
        (AuthCredential authCredential) {
      // _userService.login(authCredential);
      print(authCredential.toString() + "lets make this work");
    };

    final PhoneVerificationFailed verifailed = (AuthException authException) {
      print(authException.message.toString());
      errorMessage = authException.message;
    };

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber.trim(), // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verifId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verifId;
          },
          codeSent:
              codeSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: verified,
          verificationFailed: verifailed);
      clearController();
    } catch (e) {
      print(e.toString());
      errorMessage = e.message.toString();
      clearController();
    }
  }

  //  Register
  void _register(
      {String id, String userName, String email, String phoneNumber}) {
    _businessPartnerService.createPartner({
      'uid': id,
      'userName': userName,
      'email': email,
      'phoneNumberLogin': phoneNumber,
      'balance': 0,
      'customer': 0,
      'weight': 0,
      'accountStatus': 'Not Verified'
    });
  }

  //  VerifyCode
  void verifyCodeOTP(BuildContext context, String smsCode) async {
    final AuthCredential _authCredential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    _auth.signInWithCredential(_authCredential).then((AuthResult result) async {
      print('Authentication successful');
      if (result.user.uid == businessPartner.uid) {
        _businessPartnerModel =
            await _businessPartnerService.getPartnerById(businessPartner.uid);
        if (_businessPartnerModel == null) {
          _register(
              id: result.user.uid,
              userName: name,
              email: mail,
              phoneNumber: result.user.phoneNumber);
          print('register');
        }
        // print('from result ' + result.user.uid);
        // print('phone from result ' + result.user.phoneNumber);
        // print('from user ' + businessPartner.uid);
        // print('phone from user ' + businessPartner.phoneNumber);
        // print('name : ' + name + ' email: ' + mail);
      }
      if (_businessPartnerModel?.businessName == null) {
        _status = Status.Registering;
        changeScreenReplacement(context, AddBusinessName());
      } else if (_businessPartnerModel?.addressModel == null ||
          _businessPartnerModel?.ownerDataModel == null ||
          _businessPartnerModel?.bankAccountModel == null) {
        _status = Status.Registered;
        changeScreenReplacement(context, DataVerification());
      } else if (_businessPartnerModel?.accountStatus == 'Verify' ||
          _businessPartnerModel?.accountStatus == 'Verification Failed' ||
          _businessPartnerModel?.accountStatus == 'Verified') {
        _status = Status.Verify;
        changeScreenReplacement(context, AccountStatus());
      } else if (_businessPartnerModel?.accountStatus == 'Activate') {
        _status = Status.Activate;
        changeScreenReplacement(context, DataActivation());
      } else {
        _status = Status.Authenticated;
        changeScreenReplacement(context, MainPage());
      }
    }).catchError((e) {
      _status = Status.Unauthenticated;
      print(
          'Something has gone wrong, please try later(signInWithPhoneNumber) $e');
    });
  }

  void clearController() {
    userName.text = "";
    phoNumberLogin.text = "";
    email.text = "";
    password.text = "";
  }

  Future<void> reloadPartnerModel() async {
    _businessPartnerModel =
        await _businessPartnerService.getPartnerById(businessPartner.uid);
    notifyListeners();
  }

  Future<void> loadUserByPhone(String phoNumber) async {
    partnerByPhone = await _businessPartnerService.getPartnerByPhone(
        phoNumberLogin: phoNumber);
    // notifyListeners();
  }

  // Logout
  Future logout() async {
    try {
      _status = Status.Unauthenticated;
      notifyListeners();
      await _auth.signOut();
      print('Partner wes logout');
      return true;
    } catch (e) {
      _status = Status.Authenticating;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<void> _onStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _businessPartner = firebaseUser;
      _businessPartnerModel =
          await _businessPartnerService.getPartnerById(_businessPartner.uid);
      if (_businessPartnerModel?.businessName == null) {
        _status = Status.Registering;
      } else if (_businessPartnerModel?.addressModel == null ||
          _businessPartnerModel?.ownerDataModel == null ||
          _businessPartnerModel?.bankAccountModel == null) {
        _status = Status.Registered;
      } else if (_businessPartnerModel?.accountStatus == 'Verify' ||
          _businessPartnerModel?.accountStatus == 'Verified') {
        _status = Status.Verify;
      } else if (_businessPartnerModel?.accountStatus == 'Activate') {
        _status = Status.Activate;
      } else {
        _status = Status.Authenticated;
      }
    }
    notifyListeners();
  }

  //  Address
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
      _businessPartnerService.addAddress(
          userId: _businessPartner.uid, addressModel: address);
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      notifyListeners();
      return false;
    }
  }

  //  OwnerData
  Future<bool> addOwnerData(
      {String phoNumberOwner,
      String ktpImage,
      int nik,
      String ktpName,
      String npwpImage,
      String npwpName,
      int npwpNumber}) async {
    print("Owner is: ${ktpName.toString()}}");

    try {
      var uuid = Uuid();
      String ownerDataId = uuid.v4();
      OwnerDataModel ownerDataList = _businessPartnerModel.ownerDataModel;
      Map ownerDataModel = {
        "id": ownerDataId,
        "phoneNumberOwner": phoNumberOwner,
        "ktpImage": ktpImage,
        "nik": nik,
        "ktpName": ktpName,
        "npwpImage": npwpImage,
        "npwpNumber": npwpNumber,
        "npwpName": npwpName
      };

      OwnerDataModel ownerData = OwnerDataModel.fromMap(ownerDataModel);
      print("OWNER IS: ${ownerDataList.toString()}");
      _businessPartnerService.addOwnerData(
          userId: _businessPartner.uid, ownerDataModel: ownerData);
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      notifyListeners();
      return false;
    }
  }

  // BankAccount
  Future<bool> addBankAccount(
      {String bankName, int accountNumber, String accountName}) async {
    print("Bank Name: ${bankName.toString()}");

    try {
      var uuid = Uuid();
      String bankAccountId = uuid.v4();
      BankAccountModel bankAccountList = _businessPartnerModel.bankAccountModel;
      Map bankAccountModel = {
        "id": bankAccountId,
        "bankName": bankName,
        "accountNumber": accountNumber,
        "accountName": accountName
      };

      BankAccountModel bankAccount = BankAccountModel.fromMap(bankAccountModel);
      print("BANK ACCOUNT IS: ${bankAccountList.toString()}");
      _businessPartnerService.addBankAccount(
          userId: _businessPartner.uid, bankAccountModel: bankAccount);
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      notifyListeners();
      return false;
    }
  }
  
  // // Operational Time
  // Future<bool> addOperationalTime(
  //     {String monday,
  //     String tuesday,
  //     String wednesday,
  //     String thursday,
  //     String friday,
  //     String saturday,
  //     String sunday}) async {
  //   try {
  //     OperationalTimeModel operationalTimeList =
  //         _businessPartnerModel.operationalTimeModel;
  //     Map operationalTimeModel = {
  //       "monday": monday,
  //       "tuesday": tuesday,
  //       "wednesday": wednesday,
  //       "thursday": thursday,
  //       "friday": friday,
  //       "saturday": saturday,
  //       "sunday": sunday
  //     };

  //     OperationalTimeModel operationalTime =
  //         OperationalTimeModel.fromMap(operationalTimeModel);
  //     print("OPERATIONAL TIME IS: ${operationalTimeList.toString()}");
  //     _businessPartnerService.addOperationalTime(
  //         userId: _businessPartner.uid, operationalTimeModel: operationalTime);
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     notifyListeners();
  //     return false;
  //   }
  // }
}
