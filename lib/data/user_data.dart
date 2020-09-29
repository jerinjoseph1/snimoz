import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snimoz/constants/keys.dart';
import 'package:snimoz/models/user_model.dart';

class UserData extends ChangeNotifier {
  bool _codeSent = false;
  String _verificationId;
  String _smsCode;
  UserModel _userModel = UserModel();

  set codeSent(bool codeSent) {
    _codeSent = codeSent;
    notifyListeners();
  }

  set verificationId(String verificationId) {
    _verificationId = verificationId;
    notifyListeners();
  }

  set smsCode(String smsCode) {
    _smsCode = smsCode;
    notifyListeners();
  }

  set userModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  bool get codeSent => _codeSent;

  String get verificationId => _verificationId;

  String get smsCode => _smsCode;

  UserModel get userModel => _userModel;

  Future<void> storeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_NAME, userModel.name);
    await prefs.setString(USER_ADDRESS, userModel.address);
    await prefs.setString(USER_PHONE_NUMBER, userModel.phoneNumber);
  }

  Future<void> fetchUserData() async {
    if (userModel.name != null && userModel.name != "") return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userModel.name = prefs.getString(USER_NAME) ?? "";
    userModel.address = prefs.getString(USER_ADDRESS) ?? "";
    userModel.phoneNumber = prefs.getString(USER_PHONE_NUMBER) ?? "";
  }
}
