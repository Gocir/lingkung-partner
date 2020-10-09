import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_partner/models/operationalTimeModel.dart';

class OperationalTimeServices {
  String collection = "businessPartners";
  String subCollection = "operationalTime";
  Firestore _firestore = Firestore.instance;

  void addOperationalTime({String userId, String day, Map<String, dynamic> data}) {
    _firestore.collection(collection).document(userId).collection(subCollection).document(day).setData(data);
  }

  void updateOperationalTime({String userId, String day, Map<String, dynamic> data}) {
    _firestore.collection(collection).document(userId).collection(subCollection).document(day).updateData(data);
  }

  // Future deleteTrashReceive(String id) async {
  //   _firestore.collection(collection).document(id).delete();
  // }

  Future<List<OperationalTimeModel>> getOperationalTime() async =>
      _firestore.collection(subCollection).getDocuments().then((result) {
        List<OperationalTimeModel> operationalTimes = [];
        for (DocumentSnapshot operationalTime in result.documents) {
          operationalTimes.add(OperationalTimeModel.fromSnapshot(operationalTime));
        }
        return operationalTimes;
      });
      
  Future<List<String>> getDocument({String userId}) async =>
      _firestore.collection(collection).document(userId).collection(subCollection).getDocuments().then((snapshot) {
      List<String> document = [];
      for (DocumentSnapshot doc in snapshot.documents) {
          document.add(doc.documentID);
      }
      // print(document);
      return document;
    });
  
  // Future<CollectionReference> getCollection({String userId, CollectionReference reference}) async =>
  //     _firestore.collection(collection).document(userId).get().then((collect) {
  //     // CollectionReference collectionReference;
  //     for (CollectionReference col in collect.reference) {
  //         document.add(doc.documentID);
  //     }
  //     print(document);
  //     return CollectionReference.;
  //   });

//   Future<CollectionReference> collectionReferens =
//     _firestore.collection("cities").document("SF").get();

// for (CollectionReference collRef : collections) {
//   System.out.println("Found subcollection with id: " + collRef.getId());
// }
   
  Future<OperationalTimeModel> getTimeByDay({String userId, String day}) async =>
      _firestore
          .collection(collection)
          .document(userId)
          .collection(subCollection)
          .document(day).get()
          .then((doc) {
        return OperationalTimeModel.fromSnapshot(doc);
      });
  // Future<List<TrashReceiveModel>> getTrashReceive() async =>
  //     _firestore.collection(collection).getDocuments().then((result) {
  //       List<TrashReceiveModel> trashReceives = [];
  //       for (DocumentSnapshot trashReceive in result.documents) {
  //         trashReceives.add(TrashReceiveModel.fromSnapshot(trashReceive));
  //       }
  //       return trashReceives;
  //     });

  // Future<TrashReceiveModel> getTrashReceiveById({String id}) => _firestore
  //         .collection(collection)
  //         .document(id.toString())
  //         .get()
  //         .then((doc) {
  //       return TrashReceiveModel.fromSnapshot(doc);
  //     });

  // Future<List<TrashReceiveModel>> getTrashReceiveByPartner({String partnerId}) async =>
  //     _firestore
  //         .collection(collection)
  //         .where("partnerId", isEqualTo: partnerId)
  //         .getDocuments()
  //         .then((result) {
  //       List<TrashReceiveModel> trashReceiveByPartners = [];
  //       for (DocumentSnapshot trashReceiveByPartner in result.documents) {
  //         trashReceiveByPartners.add(TrashReceiveModel.fromSnapshot(trashReceiveByPartner));
  //       }
  //       return trashReceiveByPartners;
  //     });
  
  // Future<List<TrashReceiveModel>> getTrashReceiveByName({String partnerId, String trashName}) async =>
  //     _firestore
  //         .collection(collection)
  //         .where("partnerId", isEqualTo: partnerId)
  //         .where("trashName", isEqualTo: trashName)
  //         .getDocuments()
  //         .then((result) {
  //       List<TrashReceiveModel> trashReceiveByPartners = [];
  //       for (DocumentSnapshot trashReceiveByPartner in result.documents) {
  //         trashReceiveByPartners.add(TrashReceiveModel.fromSnapshot(trashReceiveByPartner));
  //       }
  //       return trashReceiveByPartners;
  //     });
}
