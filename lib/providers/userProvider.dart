import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//models
import 'package:lingkung_partner/models/userModel.dart';
//services
import 'package:lingkung_partner/services/userService.dart';

class UserProvider with ChangeNotifier {
  UserServices _userService = UserServices();
  UserModel _userModel;
  List<UserModel> users = [];

  // getter
  UserModel get userModel => _userModel;

  UserProvider.initialize(){
    loadUser();
  }

  loadUser() async {
    users = await _userService.getUser();
    notifyListeners();
  }

  loadSingleUser(String userId) async{
    _userModel = await _userService.getUserById(id: userId);
    notifyListeners();
  }
}
