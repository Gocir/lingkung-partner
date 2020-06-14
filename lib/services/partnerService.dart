import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_partner/models/partnerModel.dart';

class PartnerServices{

  String collection = "businessPartners";
  Firestore _firestore = Firestore.instance;

  void createPartner(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).document(id).setData(values);
  }

  void updatePartnerData(Map<String, dynamic> values){
    _firestore.collection(collection).document(values['id']).updateData(values);
  }

  Future<PartnerModel> getPartnerById(String id) => _firestore.collection(collection).document(id.toString()).get().then((doc){
    return PartnerModel.fromSnapshot(doc);
  });

  // Future<PartnerModel> getBusinessDataById(String id) => _firestore.collection(collection).document(id).get().then((doc){
  //   return PartnerModel.fromSnapshot(doc);
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