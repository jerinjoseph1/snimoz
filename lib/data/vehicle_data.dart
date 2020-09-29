import 'package:flutter/cupertino.dart';
import 'package:snimoz/cache/data_set.dart';
import 'package:snimoz/constants/keys.dart';
import 'package:snimoz/helpers/dbHelper.dart';
import 'package:snimoz/models/vehicle_model.dart';
import 'package:snimoz/utils/common_util.dart';

class VehicleData extends ChangeNotifier {
  List<VehicleModel> _vehicles = [];

  set vehicles(List<VehicleModel> vehicles) {
    _vehicles = vehicles;
    notifyListeners();
  }

  List<VehicleModel> get vehicles => _vehicles;

  bool get hasVehicle => vehicles != null && vehicles.isNotEmpty;

  Future<void> fetchVehicles() async {
    final dbHelper = DatabaseHelper.instance;
    final data = await dbHelper.queryAllVehicle();

    if (data.isEmpty || data == null) {
      vehicles = [];
      return;
    }

    vehicles = data.map((e) => VehicleModel.fromJson(e)).toList();
  }

  Future<void> saveVehicle(VehicleModel v) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.addVehicle(v);
    await fetchVehicles();
  }

  Future<void> deleteVehicle(VehicleModel v) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.deleteVehicle(v.id);
    showToast("Vehicle deleted");
    await fetchVehicles();
  }

  Future<VehicleModel> checkVehicle(String vehicleNumber) async {
    VehicleModel v;
    bool alreadyExist = false;
    bool found = false;

    for (VehicleModel vehicle in vehicles) {
      if (vehicle.number.toLowerCase() == vehicleNumber.toLowerCase()) {
        alreadyExist = true;
        break;
      }
    }

    for (Map<String, String> vehicle in VEHICLE_REGISTRATION_DATA_SET) {
      if (vehicle[VEHICLE_NUMBER].toLowerCase() ==
          vehicleNumber.toLowerCase()) {
        v = VehicleModel(
          color: vehicle[VEHICLE_COLOR],
          name: vehicle[REGISTRATION_NAME],
          type: vehicle[VEHICLE_TYPE],
          number: vehicle[VEHICLE_NUMBER],
          model: vehicle[VEHICLE_MODEL],
        );
        found = true;
        break;
      }
    }

    if (!alreadyExist && found) {
      showToast("vehicle found");
    } else if (alreadyExist) {
      v = null;
      showToast("vehicle already added");
    } else
      showToast("This vehicle is not registered");
    return v;
  }
}
