import 'package:snimoz/constants/keys.dart';

class VehicleModel {
  int id;
  String number;
  String name;
  String type;
  String color;
  String model;

  VehicleModel({
    this.id,
    this.number,
    this.name,
    this.type,
    this.color,
    this.model,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> jsonData) => VehicleModel(
        id: jsonData[VEHICLE_ID],
        number: jsonData[VEHICLE_NUMBER],
        name: jsonData[REGISTRATION_NAME],
        type: jsonData[VEHICLE_TYPE],
        color: jsonData[VEHICLE_COLOR],
        model: jsonData[VEHICLE_MODEL],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonData = Map();
    jsonData[VEHICLE_ID] = this.id;
    jsonData[VEHICLE_NUMBER] = this.number;
    jsonData[REGISTRATION_NAME] = this.name;
    jsonData[VEHICLE_TYPE] = this.type;
    jsonData[VEHICLE_COLOR] = this.color;
    jsonData[VEHICLE_MODEL] = this.model;
    return jsonData;
  }
}
