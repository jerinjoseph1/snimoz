import 'package:snimoz/constants/keys.dart';

class LicenceModel {
  String number;
  String name;
  String dob;
  String validity;
  List<String> categories;

  LicenceModel({
    this.number,
    this.name,
    this.dob,
    this.validity,
    this.categories,
  });

  factory LicenceModel.fromJson(Map<String, dynamic> jsonData) => LicenceModel(
        number: jsonData[LICENCE_NUMBER],
        name: jsonData[LICENCE_NAME],
        dob: jsonData[LICENCE_DOB],
        validity: jsonData[LICENCE_VALIDITY],
        categories: jsonData[LICENCE_CATEGORIES],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonData = Map();
    jsonData[LICENCE_NUMBER] = this.number;
    jsonData[LICENCE_NAME] = this.name;
    jsonData[LICENCE_DOB] = this.dob;
    jsonData[LICENCE_VALIDITY] = this.validity;
    jsonData[LICENCE_CATEGORIES] = this.categories;
    return jsonData;
  }
}
