import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//models
import 'package:lingkung_partner/models/courierModel.dart';
//services
import 'package:lingkung_partner/services/courierService.dart';

class CourierProvider with ChangeNotifier {
  CourierServices _courierService = CourierServices();
  CourierModel _courierModel;
  List<CourierModel> couriers = [];

  // getter
  CourierModel get courierModel => _courierModel;

  CourierProvider.initialize(){
   // print("mthrfcjer");
    loadCourier();
  }

  loadCourier() async {
    couriers = await _courierService.getCourier();
    notifyListeners();
  }

  loadSingleCourier(String courierId) async{
    _courierModel = await _courierService.getCourierById(id: courierId);
    notifyListeners();
  }
}
