// import 'package:cloud_firestore/cloud_firestore.dart';

// class PartnerModel{
//   static const ID = "id";
//   static const NAME = "name";
//   static const NOMOR_HP = "nomorHp";
//   static const NOMOR_KTP = "nomorKTP";
//   static const NOMOR_NPWP = "nomorNPWP";
//   static const IMAGE = "image";
//   static const EMAIL = "email";
//   static const BUSINESS_ID = "businessId";
//   static const STRIPE_ID = "stripeId";

//   String _id;
//   String _name;
//   String _nomorhp;
//   String _nomorktp;
//   String _nomornpwp;
//   String _image;
//   String _email;
//   String _businessId;
//   String _stripeId;


// //  getters
//   String get id => _id;
//   String get name => _name;
//   String get nomorHP => _nomorhp;
//   String get nomorKTP => _nomorktp;
//   String get nomorNPWP => _nomornpwp;
//   String get image => _image;
//   String get email => _email;
//   String get businessId => _businessId;
//   String get stripeId => _stripeId;

// //  public variable

//   PartnerModel.fromSnapshot(DocumentSnapshot snapshot){
//     _id = snapshot.data[ID];
//     _name = snapshot.data[NAME];
//     _nomorhp = snapshot.data[NOMOR_HP];
//     _nomorktp = snapshot.data[NOMOR_KTP];
//     _nomornpwp = snapshot.data[NOMOR_NPWP];
//     _image = snapshot.data[IMAGE];
//     _email = snapshot.data[EMAIL];
//     _businessId = snapshot.data[BUSINESS_ID];
//     _stripeId = snapshot.data[STRIPE_ID];
//   }

// }

import 'package:cloud_firestore/cloud_firestore.dart';

class PartnerModel{
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const ADDRESS = "address";
  static const IMAGE = "image";
  static const PHONE_NUMBER = "phoneNumber";
  static const TRASH_RECEIVE = "trashReceive";

  String _id;
  String _name;
  String _email;
  String _address;
  String _image;
  String _phoNumber;
  List<String> _trashReceive;

//  getters
  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get image => _image;
  String get address => _address;
  String get phoneNumber => _phoNumber;
  List<String> get trashReceive => _trashReceive;

//  public variable

  PartnerModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _address = snapshot.data[ADDRESS];
    _image = snapshot.data[IMAGE];
    _phoNumber = snapshot.data[PHONE_NUMBER];
  }

}