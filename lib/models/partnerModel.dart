import 'package:cloud_firestore/cloud_firestore.dart';

class PartnerModel{
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const ADDRESS = "address";
  static const IMAGE = "image";
  static const PHONE_NUMBER = "phoneNumber";
  static const TRASH_RECEIVE = "trashReceive";
  static const BALANCE = "balance";
  static const CUSTOMER = "customer";
  static const WEIGHT = "weight";

  String _id;
  String _name;
  String _email;
  String _address;
  String _image;
  int _phoNumber;
  int _balance;
  int _customer;
  int _weight;

//  getters
  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get image => _image;
  String get address => _address;
  int get phoNumber => _phoNumber;
  int get balance => _balance;
  int get customer => _customer;
  int get weight => _weight;

//  public variable

  PartnerModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _address = snapshot.data[ADDRESS];
    _image = snapshot.data[IMAGE];
    _phoNumber = snapshot.data[PHONE_NUMBER];
    _balance = snapshot.data[BALANCE];
    _customer = snapshot.data[CUSTOMER];
    _weight = snapshot.data[WEIGHT];
  }

}