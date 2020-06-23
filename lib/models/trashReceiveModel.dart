import 'package:cloud_firestore/cloud_firestore.dart';

class TrashReceiveModel{
  static const ID = "id";
  static const PRICE = "price";
  static const TRASH_NAME = "trashName";
  static const IMAGE = "image";
  static const PARTNER_ID = "partnerId";

  String _id;
  int _price;
  String _trashName;
  String _image;
  String _partnerId;

//  getters
  String get id => _id;
  int get price => _price;
  String get trashName => _trashName;
  String get image => _image;
  String get partnerId => _partnerId;

// public variable

  TrashReceiveModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _price = snapshot.data[PRICE];
    _trashName = snapshot.data[TRASH_NAME];
    _image = snapshot.data[IMAGE];
    _partnerId = snapshot.data[PARTNER_ID];
  }

}