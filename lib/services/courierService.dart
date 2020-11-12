import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_partner/models/courierModel.dart';

class CourierServices{

  String collection = "couriers";
  Firestore _firestore = Firestore.instance;

  Future<List<CourierModel>> getCourier() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<CourierModel> partners = [];
        for (DocumentSnapshot partner in result.documents) {
          partners.add(CourierModel.fromSnapshot(partner));
        }
        return partners;
      });

  Future<CourierModel> getCourierById({String id}) => _firestore
          .collection(collection)
          .document(id.toString())
          .get()
          .then((doc) {
        if (doc.data == null) {
          return null;
        }
        return CourierModel.fromSnapshot(doc);
      });

  // Future<CourierModel> getBusinessDataById(String id) => _firestore.collection(collection).document(id).get().then((doc){
  //   return CourierModel.fromSnapshot(doc);
  // });

  // void addToCart({String partnerId, Map cartItem}){
  //   print("THE USER ID IS: $partnerId");
  //   print("cart items are: ${cartItem.toString()}");
  //   _firestore.collection(collection).document(partnerId).updateData({
  //     "cart": FieldValue.arrayUnion([cartItem])
  //   });
  // }

  // void removeFromCart({String partnerId, Map cartItem}){
  //   print("THE USER ID IS: $partnerId");
  //   print("cart items are: ${cartItem.toString()}");
  //   _firestore.collection(collection).document(partnerId).updateData({
  //     "cart": FieldValue.arrayRemove([cartItem])
  //   });
  // }

}