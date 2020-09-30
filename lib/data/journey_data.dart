import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:snimoz/models/entry_exit_point_model.dart';
import 'package:snimoz/models/licence_model.dart';
import 'package:snimoz/models/restricted_zones_model.dart';
import 'package:snimoz/models/user_model.dart';
import 'package:snimoz/models/vehicle_model.dart';
import 'package:snimoz/utils/common_util.dart';

class JourneyData extends ChangeNotifier {
  String _licenceNumber = "";
  VehicleModel _vehicle;
  List<double> _speedList = [0.0];
  Position _position;
  bool _showEndButton = false;
  String _id;
  List<EntryExitPointModel> _listPoints = [];
  List<RestrictedZonesModel> _listZones = [];
  EntryExitPointModel _entryPoint;
  String _date;
  List<Map<String, dynamic>> _journeyList = [];

  set vehicle(VehicleModel vehicle) {
    _vehicle = vehicle;
    notifyListeners();
  }

  set journeyList(List<Map<String, dynamic>> journeyList) {
    _journeyList = journeyList;
    notifyListeners();
  }

  set date(String date) {
    _date = date;
    notifyListeners();
  }

  set entryPoint(EntryExitPointModel entryPoint) {
    _entryPoint = entryPoint;
    notifyListeners();
  }

  set listPoints(List<EntryExitPointModel> listPoints) {
    _listPoints = listPoints;
    notifyListeners();
  }

  set listZones(List<RestrictedZonesModel> listZones) {
    _listZones = listZones;
    notifyListeners();
  }

  set id(String id) {
    _id = id;
    notifyListeners();
  }

  set showEndButton(bool showEndButton) {
    _showEndButton = showEndButton;
    notifyListeners();
  }

  set position(Position position) {
    _position = position;
    notifyListeners();
  }

  set licenceNumber(String licenceNumber) {
    _licenceNumber = licenceNumber;
    notifyListeners();
  }

  set speedList(List<double> speedList) {
    _speedList = speedList;
    notifyListeners();
  }

  VehicleModel get vehicle => _vehicle;

  List<EntryExitPointModel> get listPoints => _listPoints;

  List<Map<String, dynamic>> get journeyList => _journeyList;

  List<RestrictedZonesModel> get listZones => _listZones;

  EntryExitPointModel get entryPoint => _entryPoint;

  bool get showEndButton => _showEndButton;

  String get id => _id;

  String get date => _date;

  Position get position => _position;

  String get licenceNumber => _licenceNumber;

  List<double> get speedList => _speedList;

  Future<void> addJourney(
      UserModel userModel, LicenceModel licenceModel) async {
    Response response;
    Dio dio = Dio();
    date = DateTime.now().toString();
    final data = {
      "name": licenceModel.name,
      "mob": userModel.phoneNumber,
      "vehicleType": vehicle.type,
      "vehicleReg": vehicle.number,
      "time": date,
      "realtimeLocation": [position.latitude, position.longitude].toString(),
    };
    try {
      response = await dio.post(
        "https://snimoz-api.herokuapp.com/journeyRegistration",
        data: data,
      );
      id = response.data["_id"];
      showEndButton = true;
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> endJourney(
      UserModel userModel, LicenceModel licenceModel) async {
    Response response;
    Dio dio = Dio();
    for (var i in speedList) {}
    final data = {
      "name": licenceModel.name,
      "mob": userModel.phoneNumber,
      "vehicleType": vehicle.type,
      "vehicleReg": vehicle.number,
      "time": date,
      "realtimeLocation": [position.latitude, position.longitude].toString(),
    };
    try {
      response = await dio.delete(
        "https://snimoz-api.herokuapp.com/journeyDelete/" + id,
      );
      print(response.data);
      showToast("Your journey has ended");
      journeyList.add(data);
      showEndButton = false;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getEntryExitPoints() async {
    entryPoint = null;
    Response response;
    Dio dio = Dio();
    try {
      response = await dio.get(
        "https://snimoz-api.herokuapp.com/getEntryExitPoint",
      );
      print(response.data);
      if (response.data != null) {
        listPoints = [];
        response.data.forEach((e) {
          listPoints.add(EntryExitPointModel.fromJson(e));
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> pushLocationViolation(
      UserModel userModel, LicenceModel licenceModel) async {
    Response response;
    Dio dio = Dio();
    String currentTime = DateTime.now().toString();
    final data = {
      "id": id,
      "name": licenceModel.name,
      "mob": userModel.phoneNumber,
      "vehicleType": vehicle.type,
      "vehicleReg": vehicle.number,
      "time": date,
      "violationTime": currentTime,
      "violationPoint": [position.latitude, position.longitude].toString(),
    };
    try {
      response = await dio.post(
        "https://snimoz-api.herokuapp.com/postSpeedViolation",
        data: data,
      );
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateLocation() async {
    Position position = await getCurrentPosition();
    Response response;
    Dio dio = Dio();
    final data = {
      "id": id,
      "realtimeLocation": [position.latitude, position.longitude].toString(),
    };
    try {
      response = await dio.post(
        "https://snimoz-api.herokuapp.com/updateRealtimeLocation",
        data: data,
      );
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getRestrictedZones() async {
    Response response;
    Dio dio = Dio();
    try {
      response = await dio.get(
        "https://snimoz-api.herokuapp.com/getRestrictedZone",
      );
      print(response.data);
      if (response.data != null) {
        listZones = [];
        response.data.forEach((e) {
          listZones.add(RestrictedZonesModel.fromJson(e));
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkRestriction(
      UserModel userModel, LicenceModel licenceModel) async {
    Position position = await getCurrentPosition();
    Response response;
    Dio dio = Dio();

    bool found = false;
    for (RestrictedZonesModel r in listZones) {
//        print(l);
      List<Position> ll = [];
      for (var i in r.coordinates) {
        ll.add(Position(latitude: i[1], longitude: i[0]));
      }
      found = await _checkIfValidMarker(
          Position(latitude: position.latitude, longitude: position.longitude),
          ll);
      if (found == true) {
        break;
      }
    }
    // if (!found) return;

    String currentTime = DateTime.now().toString();
    final data = {
      "id": id,
      "name": licenceModel.name,
      "mob": userModel.phoneNumber,
      "vehicleType": vehicle.type,
      "vehicleReg": vehicle.number,
      "time": date,
      "violationTime": currentTime,
      "violationPoint": [position.latitude, position.longitude].toString(),
    };
    try {
      response = await dio.post(
        "https://snimoz-api.herokuapp.com/postZoneViolation",
        data: data,
      );
      print(response.statusCode);
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  _checkIfValidMarker(Position tap, List<Position> vertices) {
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }
    print(((intersectCount % 2) == 1));
    return ((intersectCount % 2) == 1); // odd = inside, even = outside;
  }

  bool rayCastIntersect(Position tap, Position vertA, Position vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false; // a and b can't both be above or below pt.y, and a or
      // b must be east of pt.x
    }

    double m = (aY - bY) / (aX - bX); // Rise over run
    double bee = (-aX) * m + aY; // y = mx + b
    double x = (pY - bee) / m; // algebra is neat!

    return x > pX;
  }
}
