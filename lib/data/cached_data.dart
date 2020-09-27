import 'package:flutter/cupertino.dart';
import 'package:snimoz/constants/keys.dart';

class VehicleData extends ChangeNotifier {
  List<Map<String, dynamic>> _vehicleRegistrationDataSet = [
    {
      VEHICLE_NUMBER: "AS-01-B-1234",
      REGISTRATION_NAME: "Raj",
      VEHICLE_TYPE: "Three Wheeler",
      VEHICLE_COLOR: "Red",
    },
    {
      VEHICLE_NUMBER: "AS-01-C-1111",
      REGISTRATION_NAME: "Khan",
      VEHICLE_TYPE: "Four Wheeler",
      VEHICLE_COLOR: "Black",
    },
    {
      VEHICLE_NUMBER: "AS-02-AD-9898",
      REGISTRATION_NAME: "Radha",
      VEHICLE_TYPE: "Two Wheeler",
      VEHICLE_COLOR: "White",
    }
  ];

  List<Map<String, dynamic>> get vehicleRegistrationDataSet =>
      _vehicleRegistrationDataSet;
}