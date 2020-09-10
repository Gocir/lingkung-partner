import 'package:flutter/material.dart';
import 'package:lingkung_partner/models/trashModel.dart';
import 'package:lingkung_partner/services/trashService.dart';

class TrashProvider with ChangeNotifier{
  TrashServices _trashService = TrashServices();
  TrashModel _trashModel;
  List<TrashModel> trashes = [];

  // Getter
  TrashModel get trashModel => _trashModel;

  // TrashProvider.initialize(){
  //   loadTrash();
  // }

  // loadTrash() async {
  //   trashes = await _trashService.getTrashes();
  //   notifyListeners();
  // }

  // loadSingleTrash({String trashId}) async{
  //   _trashModel = await _trashService.getTrashesById(id: trashId);
  //   notifyListeners();
  // }

  // Future loadTrashReceiveByPartner({String partnerId})async{
  //   trashReceiveByPartner = await _trashReceiveService.getTrashReceiveByPartner(partnerId: partnerId);
  //   notifyListeners();
  // }

}