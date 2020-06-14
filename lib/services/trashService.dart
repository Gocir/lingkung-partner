import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class TrashServices{
  Firestore _firestore = Firestore.instance;
  String collection = 'trashes';

  void addTrash(Map<String, dynamic> data) {
    var id = Uuid();
    String trashId = id.v1();
    data["id"] = trashId;
    _firestore.collection(collection).document(trashId).setData(data);
  }

  Future<List<DocumentSnapshot>> getTrashes() =>
      _firestore.collection(collection).getDocuments().then((snaps) {
        return snaps.documents;
      });


  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) =>
      _firestore.collection(collection).where('name', isEqualTo: suggestion).getDocuments().then((snap){
        return snap.documents;
      });
  // void updateTrash(Map<String, dynamic> values) {
  //   _firestore.collection(collection).document(values['id']).updateData(values);
  // }

  // Future<List<TrashModel>> getTrashes() async =>
  //     _firestore.collection(collection).getDocuments().then((result) {
  //       List<TrashModel> trashes = [];
  //       for (DocumentSnapshot trash in result.documents) {
  //         trashes.add(TrashModel.fromSnapshot(trash));
  //       }
  //       return trashes;
  //     });

  // Future<TrashModel> getTrashesById({String id}) => _firestore
  //         .collection(collection)
  //         .document(id.toString())
  //         .get()
  //         .then((doc) {
  //       return TrashModel.fromSnapshot(doc);
  //     });
}