import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snimoz/cache/data_set.dart';
import 'package:snimoz/constants/keys.dart';
import 'package:snimoz/models/licence_model.dart';
import 'package:snimoz/utils/common_util.dart';

class LicenceData extends ChangeNotifier {
  LicenceModel _myLicence = LicenceModel();

  set myLicence(LicenceModel myLicence) {
    _myLicence = myLicence;
    notifyListeners();
  }

  LicenceModel get myLicence => _myLicence;

  bool get hasLicence => myLicence.number != null && myLicence.number != "";

  Future<void> storeLicence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(LICENCE_NAME, myLicence.name);
    await prefs.setString(LICENCE_NUMBER, myLicence.number);
    await prefs.setString(LICENCE_VALIDITY, myLicence.validity);
    await prefs.setString(LICENCE_DOB, myLicence.dob);
    await prefs.setStringList(LICENCE_CATEGORIES, myLicence.categories);
  }

  Future<void> fetchLicence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LicenceModel l = LicenceModel(
      name: prefs.getString(LICENCE_NAME) ?? "",
      number: prefs.getString(LICENCE_NUMBER) ?? "",
      validity: prefs.getString(LICENCE_VALIDITY) ?? "",
      dob: prefs.getString(LICENCE_DOB) ?? "",
      categories: prefs.getStringList(LICENCE_CATEGORIES) ?? [],
    );
    myLicence = l;
  }

  Future<void> deleteLicence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(LICENCE_NAME);
    await prefs.remove(LICENCE_NUMBER);
    await prefs.remove(LICENCE_VALIDITY);
    await prefs.remove(LICENCE_DOB);
    await prefs.remove(LICENCE_CATEGORIES);
    myLicence = LicenceModel();
  }

  Future<void> addLicence(String licenceNumber, String name) async {
    LicenceModel l;

    for (Map<String, dynamic> licence in LICENCE_DATA_SET) {
      if (licence[LICENCE_NUMBER].toLowerCase() ==
              licenceNumber.toLowerCase() &&
          licence[LICENCE_NAME].toLowerCase() == name.toLowerCase()) {
        l = LicenceModel(
          number: licence[LICENCE_NUMBER],
          name: licence[LICENCE_NAME],
          dob: licence[LICENCE_DOB],
          validity: licence[LICENCE_VALIDITY],
          categories: licence[LICENCE_CATEGORIES],
        );
        break;
      }
    }

    if (l == null)
      showToast("Licence not found");
    else {
      myLicence = l;
      await storeLicence();
      showToast("Licence added");
    }
  }
}
