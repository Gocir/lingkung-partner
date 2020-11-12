import 'package:flutter/material.dart';
import 'package:lingkung_partner/models/trashReceiveModel.dart';
import 'package:lingkung_partner/services/trashReceiveService.dart';

class TrashReceiveProvider with ChangeNotifier{
  TrashReceiveServices _trashReceiveService = TrashReceiveServices();
  TrashReceiveModel _trashReceiveModel;
  List<TrashReceiveModel> trashReceives = [];
  List<TrashReceiveModel> trashReceiveByPartner = [];
  List<TrashReceiveModel> trashReceiveByName = [];

  // Getter
  TrashReceiveModel get trashReceiveModel => _trashReceiveModel;

  TrashReceiveProvider.initialize(){
    loadTrashReceive();
  }

  loadTrashReceive() async {
    trashReceives = await _trashReceiveService.getTrashReceive();
    notifyListeners();
  }

  loadSingleTrashReceive({String trashReceiveId, String partnerId}) async{
    _trashReceiveModel = await _trashReceiveService.getTrashReceiveById(id: trashReceiveId);
    notifyListeners();
  }

  loadTrashReceiveByPartner(String partnerId)async{
    trashReceiveByPartner = await _trashReceiveService.getTrashReceiveByPartner(partnerId: partnerId);
    notifyListeners();
  }
  
  loadTrashReceiveByName(String partnerId, String trashName) async {
    trashReceiveByName = await _trashReceiveService.getTrashReceiveByName(partnerId: partnerId, trashName: trashName);
    notifyListeners();
  }

}
// class TrashReceiveProvider with ChangeNotifier{
//   TrashReceiveServices _trashReceiveService = TrashReceiveServices();
//   TrashReceiveModel _trashReceiveModel;
//   List<TrashReceiveModel> trashReceives = [];
//   List<TrashReceiveModel> trashReceiveByPartner = [];
//   List<TrashReceiveModel> trashReceiveByName = [];

//   // Getter
//   TrashReceiveModel get trashReceiveModel => _trashReceiveModel;

//   TrashReceiveProvider.initialize(){
//     loadTrashReceive();
//   }

//   loadTrashReceive() async {
//     trashReceives = await _trashReceiveService.getTrashReceive();
//     notifyListeners();
//   }

//   loadSingleTrashReceive({String trashReceiveId}) async{
//     _trashReceiveModel = await _trashReceiveService.getTrashReceiveById(id: trashReceiveId);
//     notifyListeners();
//   }

//   loadTrashReceiveByPartner(String partnerId)async{
//     trashReceiveByPartner = await _trashReceiveService.getTrashReceiveByPartner(partnerId: partnerId);
//     notifyListeners();
//   }
  
//   loadTrashReceiveByName(String partnerId, String trashName)async{
//     trashReceiveByName = await _trashReceiveService.getTrashReceiveByName(partnerId: partnerId, trashName: trashName);
//     notifyListeners();
//   }

// }