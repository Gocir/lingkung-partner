import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_partner/models/addressModel.dart';
import 'package:lingkung_partner/models/bankAccountModel.dart';
import 'package:lingkung_partner/models/ownerDataModel.dart';
import 'package:lingkung_partner/models/operationalTimeModel.dart';

class PartnerModel{
  static const ID = "uid";
  static const EMAIL = "email";
  static const PHONE_NUMBER_LOGIN = "phoneNumberLogin";
  static const USER_NAME = "userName";
  static const PARTNER_BUSINESS_NAME = "businessName";
  static const ADDRESS = "address";
  static const OWNER_DATA = "ownerData";
  static const BANK_ACCOUNT = "bankAccount";
  // static const OPERATIONAL_TIME = "operationalTime";
  static const TRASH_RECEIVE = "trashReceive";
  static const IMAGE = "image";
  static const BALANCE = "balance";
  static const CUSTOMER = "customer";
  static const WEIGHT = "weight";
  static const ACCOUNT_STATUS = "accountStatus";

  String _id;
  String _email;
  String _phoNumberLogin;
  String _userName;
  String _businessName;
  String _image;
  int _balance;
  int _customer;
  int _weight;
  String _accountStatus;

//  getters
  String get id => _id;
  String get email => _email;
  String get phoNumberLogin => _phoNumberLogin;
  String get userName => _userName;
  String get businessName => _businessName;
  String get image => _image;
  int get balance => _balance;
  int get customer => _customer;
  int get weight => _weight;
  String get accountStatus => _accountStatus;

//  public variable
  AddressModel addressModel;
  OwnerDataModel ownerDataModel;
  BankAccountModel bankAccountModel;
  OperationalTimeModel operationalTimeModel;

  PartnerModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _email = snapshot.data[EMAIL];
    _phoNumberLogin = snapshot.data[PHONE_NUMBER_LOGIN];
    _userName = snapshot.data[USER_NAME];
    _businessName = snapshot.data[PARTNER_BUSINESS_NAME];
    (snapshot.data[ADDRESS] != null)
        ? addressModel = AddressModel.fromMap(snapshot.data[ADDRESS])
        : addressModel = snapshot.data[ADDRESS];
    (snapshot.data[OWNER_DATA] != null)
        ? ownerDataModel = OwnerDataModel.fromMap(snapshot.data[OWNER_DATA])
        : ownerDataModel = snapshot.data[OWNER_DATA];
    (snapshot.data[BANK_ACCOUNT] != null)
        ? bankAccountModel = BankAccountModel.fromMap(snapshot.data[BANK_ACCOUNT])
        : bankAccountModel = snapshot.data[BANK_ACCOUNT];
    // (snapshot.data[OPERATIONAL_TIME] != null)
    //     ? operationalTimeModel = OperationalTimeModel.fromMap(snapshot.data[OPERATIONAL_TIME])
    //     : operationalTimeModel = snapshot.data[OPERATIONAL_TIME];
    _image = snapshot.data[IMAGE];
    _balance = snapshot.data[BALANCE];
    _customer = snapshot.data[CUSTOMER];
    _weight = snapshot.data[WEIGHT];
    _accountStatus = snapshot.data[ACCOUNT_STATUS];
  }

}