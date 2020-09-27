import 'package:snimoz/constants/keys.dart';

class UserModel {
  String name;
  String address;
  String phoneNumber;

  UserModel({
    this.name,
    this.address,
    this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) => UserModel(
        name: jsonData[USER_NAME],
        address: jsonData[USER_ADDRESS],
        phoneNumber: jsonData[USER_PHONE_NUMBER],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonData = Map();

    jsonData[USER_NAME] = this.name;
    jsonData[USER_ADDRESS] = this.address;
    jsonData[USER_PHONE_NUMBER] = this.phoneNumber;

    return jsonData;
  }
}
