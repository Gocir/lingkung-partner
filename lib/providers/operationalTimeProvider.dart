import 'package:flutter/material.dart';
import 'package:lingkung_partner/models/operationalTimeModel.dart';
import 'package:lingkung_partner/services/operationalTimeService.dart';

class OperationalTimeProvider with ChangeNotifier {
  OperationalTimeServices _operationalTimeService = OperationalTimeServices();
  OperationalTimeModel _operationalTimeModel;
  OperationalTimeModel _mondayTime;
  OperationalTimeModel _tuesdayTime;
  OperationalTimeModel _wednesdayTime;
  OperationalTimeModel _thursdayTime;
  OperationalTimeModel _fridayTime;
  OperationalTimeModel _saturdayTime;
  OperationalTimeModel _sundayTime;
  List<OperationalTimeModel> operationalTimes = [];
  List<OperationalTimeModel> timeByDays = [];
  List<String> documents = [];

  // Getter
  OperationalTimeModel get operationalTimeModel => _operationalTimeModel;
  OperationalTimeModel get mondayTime => _mondayTime;
  OperationalTimeModel get tuesdayTime => _tuesdayTime;
  OperationalTimeModel get wednesdayTime => _wednesdayTime;
  OperationalTimeModel get thursdayTime => _thursdayTime;
  OperationalTimeModel get fridayTime => _fridayTime;
  OperationalTimeModel get saturdayTime => _saturdayTime;
  OperationalTimeModel get sundayTime => _sundayTime;

  OperationalTimeProvider.initialize() {
    loadOperationalTime();
  }

  loadOperationalTime() async {
    operationalTimes = await _operationalTimeService.getOperationalTime();
    notifyListeners();
  }

  loadTimeByDay(String userId, String day) async {
    _operationalTimeModel =
        await _operationalTimeService.getTimeByDay(userId: userId, day: day);
    notifyListeners();
  }
  loadTimeByMonDay(String userId, String day) async {
    _mondayTime =
        await _operationalTimeService.getTimeByDay(userId: userId, day: day);
    notifyListeners();
  }
  loadTimeByTuesDay(String userId, String day) async {
    _tuesdayTime=
        await _operationalTimeService.getTimeByDay(userId: userId, day: day);
    notifyListeners();
  }
  loadTimeByWednesDay(String userId, String day) async {
    _wednesdayTime =
        await _operationalTimeService.getTimeByDay(userId: userId, day: day);
    notifyListeners();
  }
  loadTimeByThursDay(String userId, String day) async {
    _thursdayTime =
        await _operationalTimeService.getTimeByDay(userId: userId, day: day);
    notifyListeners();
  }
  loadTimeByFriDay(String userId, String day) async {
    _fridayTime =
        await _operationalTimeService.getTimeByDay(userId: userId, day: day);
    notifyListeners();
  }
  loadTimeBySaturDay(String userId, String day) async {
    _saturdayTime =
        await _operationalTimeService.getTimeByDay(userId: userId, day: day);
    notifyListeners();
  }
  loadTimeBySunDay(String userId, String day) async {
    _sundayTime =
        await _operationalTimeService.getTimeByDay(userId: userId, day: day);
    notifyListeners();
  }

  getDocument(String userId) async {
    documents = await _operationalTimeService.getDocument(userId: userId);
    notifyListeners();
  }

  // Manipulate Time
  Future<void> addTime(
      {String userId, String day, String fullTime, String closed, String openTime, String closingTime}) async {
    try {
      Map<String, dynamic> timeData = {
        "fullTime": fullTime,
        "closed": closed,
        "openTime": openTime,
        "closingTime": closingTime,
        // "setTime": operationalTimeModel.setTime
      };
      
      _operationalTimeService.addOperationalTime(userId: userId, day: day, data: timeData);

      print("THE DAY IS: ${day.toString()}");
      print("OPERATIONAL TIME IS: ${timeData.toString()}");
      notifyListeners();
      // return ;
    } catch (e) {
      print(e.toString());
      notifyListeners();
      // return ;
    }
  }
  
  Future<bool> updateTime(
      {String userId, String day, String fullTime, String closed, String openTime, String closingTime}) async {
    try {
      Map<String, dynamic> timeData = {
        "fullTime": fullTime,
        "closed": closed,
        "openTime": openTime,
        "closingTime": closingTime,
        // "setTime": operationalTimeModel.setTime
      };
      
      _operationalTimeService.updateOperationalTime(userId: userId, day: day, data: timeData);

      print("THE USER ID IS: ${userId.toString()}");
      print("THE DAY IS: ${day.toString()}");
      print("OPERATIONAL TIME IS: ${timeData.toString()}");
      
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      notifyListeners();
      return false;
    }
  }
}
