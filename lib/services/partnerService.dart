import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_partner/models/addressModel.dart';
import 'package:lingkung_partner/models/bankAccountModel.dart';
import 'package:lingkung_partner/models/ownerDataModel.dart';
import 'package:lingkung_partner/models/operationalTimeModel.dart';
import 'package:lingkung_partner/models/partnerModel.dart';

class PartnerServices {
  String collection = "businessPartners";
  Firestore _firestore = Firestore.instance;

  void createPartner(Map<String, dynamic> values) {
    String id = values["uid"];
    _firestore.collection(collection).document(id).setData(values);
  }

  void updatePartnerData(Map<String, dynamic> values) {
    _firestore
        .collection(collection)
        .document(values['uid'])
        .updateData(values);
  }

  Future<PartnerModel> getPartnerById(String id) =>
      _firestore.collection(collection).document(id).get().then((doc) {
        if (doc.data == null) {
          return null;
        }
        return PartnerModel.fromSnapshot(doc);
      });

  Future<List<PartnerModel>> getPartnerByPhone({String phoNumberLogin}) async =>
      _firestore
          .collection(collection)
          .where("phoneNumberLogin", isEqualTo: phoNumberLogin)
          .getDocuments()
          .then((result) {
        List<PartnerModel> partnerByPhones = [];
        for (DocumentSnapshot partnerByPhone in result.documents) {
          partnerByPhones.add(PartnerModel.fromSnapshot(partnerByPhone));
        }
        return partnerByPhones;
      });

  void addAddress({String userId, AddressModel addressModel}) {
    print("THE USER ID IS: $userId");
    print("address are: ${addressModel.toString()}");
    _firestore
        .collection(collection)
        .document(userId)
        .updateData({"address": addressModel.toMap()});
  }

  void addOwnerData({String userId, OwnerDataModel ownerDataModel}) {
    print("THE USER ID IS: $userId");
    print("owner is: ${ownerDataModel.toString()}");
    _firestore
        .collection(collection)
        .document(userId)
        .updateData({"ownerData": ownerDataModel.toMap()});
  }

  void addBankAccount({String userId, BankAccountModel bankAccountModel}) {
    print("THE USER ID IS: $userId");
    print("owner is: ${bankAccountModel.toString()}");
    _firestore
        .collection(collection)
        .document(userId)
        .updateData({"bankAccount": bankAccountModel.toMap()});
  }

  // void addOperationalTime(
  //     {String userId,
  //     OperationalTimeModel operationalTimeModel,
  //     String day,
  //     String time,
  //     String timeSpan}) {
  //   print("THE USER ID IS: $userId");
  //   if (operationalTimeModel != null) {
  //   print("Operational Time is: ${operationalTimeModel.toString()}");
  //     _firestore
  //         .collection(collection)
  //         .document(userId)
  //         .updateData({"operationalTime": operationalTimeModel.toMap()});
  //   } else if (timeSpan != null) {
  //   print("Day is: ${day.toString()}");
  //   print("Time Span: ${timeSpan.toString()}");
  //     _firestore
  //         .collection(collection)
  //         .document(userId).collection('Operational Time').document(day)
  //         .updateData({"setTime": timeSpan});
  //   } else {
  //   print("Day is: ${day.toString()}");
  //     _firestore
  //         .collection(collection)
  //         .document(userId)
  //         .updateData({"operationalTime.${day.toString()}": time});
  //   }
  // }
}
