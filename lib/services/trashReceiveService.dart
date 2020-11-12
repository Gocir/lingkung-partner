import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_partner/models/trashReceiveModel.dart';
import 'package:uuid/uuid.dart';

class TrashReceiveServices {
  String collection = "businessPartners";
  String subCollection = "trashReceives";
  Firestore _firestore = Firestore.instance;

  void addTrashReceive(Map<String, dynamic> data) {
    var id = Uuid();
    String trashReceiveId = id.v1();
    data["id"] = trashReceiveId;
    _firestore.collection(collection).document(data['partnerId']).collection(subCollection).document(trashReceiveId).setData(data);
  }

  void updateTrashReceive(Map<String, dynamic> values) {
    _firestore.collection(collection).document(values['id']).collection(subCollection).document(values['trashReceiveId']).updateData(values);
  }

  Future<void> deleteTrashReceive(TrashReceiveModel trash) async {
    _firestore.collection(collection).document(trash.partnerId).collection(subCollection).document(trash.id).delete();
  }

  Future<List<TrashReceiveModel>> getTrashReceive() async =>
      _firestore.collection(subCollection).getDocuments().then((result) {
        List<TrashReceiveModel> trashReceives = [];
        for (DocumentSnapshot trashReceive in result.documents) {
          trashReceives.add(TrashReceiveModel.fromSnapshot(trashReceive));
        }
        return trashReceives;
      });

  Future<TrashReceiveModel> getTrashReceiveById({String partnerId, String id}) => _firestore
          .collection(collection)
          .document(partnerId)
          .collection(subCollection)
          .document(id)
          .get()
          .then((doc) {
        return TrashReceiveModel.fromSnapshot(doc);
      });

  Future<List<TrashReceiveModel>> getTrashReceiveByPartner({String partnerId}) async =>
      _firestore
          .collection(collection)
          .document(partnerId)
          .collection(subCollection)
          .where("partnerId", isEqualTo: partnerId)
          .getDocuments()
          .then((result) {
        List<TrashReceiveModel> trashReceiveByPartners = [];
        for (DocumentSnapshot trashReceiveByPartner in result.documents) {
          trashReceiveByPartners.add(TrashReceiveModel.fromSnapshot(trashReceiveByPartner));
        }
        return trashReceiveByPartners;
      });
  
  Future<List<TrashReceiveModel>> getTrashReceiveByName({String partnerId, String trashName}) async =>
      _firestore
          .collection(collection)
          .document(partnerId)
          .collection(subCollection)
          .where("trashName", isEqualTo: trashName)
          .getDocuments()
          .then((result) {
        List<TrashReceiveModel> trashReceiveByNames = [];
        for (DocumentSnapshot trashReceiveByName in result.documents) {
          trashReceiveByNames.add(TrashReceiveModel.fromSnapshot(trashReceiveByName));
        }
        return trashReceiveByNames;
      });
}
// class TrashReceiveServices {
//   // static CollectionReference firestore = Firestore.instance.collection('trashReceivePartner');
//   String collection = "trashReceives";
//   Firestore _firestore = Firestore.instance;

//   void addTrashReceive(Map<String, dynamic> data) {
//     var id = Uuid();
//     String trashReceiveId = id.v1();
//     data["id"] = trashReceiveId;
//     _firestore.collection(collection).document(trashReceiveId).setData(data);
//   }

//   void updateTrashReceive(Map<String, dynamic> values) {
//     _firestore.collection(collection).document(values['id']).updateData(values);
//   }

//   Future deleteTrashReceive(String id) async {
//     _firestore.collection(collection).document(id).delete();
//   }

//   Future<List<TrashReceiveModel>> getTrashReceive() async =>
//       _firestore.collection(collection).getDocuments().then((result) {
//         List<TrashReceiveModel> trashReceives = [];
//         for (DocumentSnapshot trashReceive in result.documents) {
//           trashReceives.add(TrashReceiveModel.fromSnapshot(trashReceive));
//         }
//         return trashReceives;
//       });

//   Future<TrashReceiveModel> getTrashReceiveById({String id}) => _firestore
//           .collection(collection)
//           .document(id.toString())
//           .get()
//           .then((doc) {
//         return TrashReceiveModel.fromSnapshot(doc);
//       });

//   Future<List<TrashReceiveModel>> getTrashReceiveByPartner({String partnerId}) async =>
//       _firestore
//           .collection(collection)
//           .where("partnerId", isEqualTo: partnerId)
//           .getDocuments()
//           .then((result) {
//         List<TrashReceiveModel> trashReceiveByPartners = [];
//         for (DocumentSnapshot trashReceiveByPartner in result.documents) {
//           trashReceiveByPartners.add(TrashReceiveModel.fromSnapshot(trashReceiveByPartner));
//         }
//         return trashReceiveByPartners;
//       });
  
//   Future<List<TrashReceiveModel>> getTrashReceiveByName({String partnerId, String trashName}) async =>
//       _firestore
//           .collection(collection)
//           .where("partnerId", isEqualTo: partnerId)
//           .where("trashName", isEqualTo: trashName)
//           .getDocuments()
//           .then((result) {
//         List<TrashReceiveModel> trashReceiveByPartners = [];
//         for (DocumentSnapshot trashReceiveByPartner in result.documents) {
//           trashReceiveByPartners.add(TrashReceiveModel.fromSnapshot(trashReceiveByPartner));
//         }
//         return trashReceiveByPartners;
//       });
// }
