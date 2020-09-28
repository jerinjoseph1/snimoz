import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snimoz/data/vehicle_data.dart';
import 'package:snimoz/models/vehicle_model.dart';
import 'package:snimoz/utils/common_util.dart';

void addVehicleSheet(BuildContext context) async {
  showModalBottomSheet(
    backgroundColor: Colors.indigo[50],
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    context: context,
    builder: (_) {
      return AddVehicleSheet();
    },
  );
}

class AddVehicleSheet extends StatefulWidget {
  @override
  _AddVehicleSheetState createState() => _AddVehicleSheetState();
}

class _AddVehicleSheetState extends State<AddVehicleSheet> {
  final _vehicleNumFormKey = GlobalKey<FormState>();
  final _regNameFormKey = GlobalKey<FormState>();
  final TextEditingController vehicleNumEditCtrl = TextEditingController();
  final TextEditingController regNameEditCtrl = TextEditingController();

  VehicleModel vehicle;
  bool verify = false;

  @override
  Widget build(BuildContext context) {
    final VehicleData vehicleData = Provider.of<VehicleData>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: !verify,
            child: Form(
              key: _vehicleNumFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: vehicleNumEditCtrl,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            // color: APP_BROWN_COLOR,
                            ),
                      ),
                      icon: Icon(
                        Icons.drag_handle,
                        size: 20,
                      ),
                      labelText: 'Vehicle Number',
                      hintText: "XX - xx - X - xxxx",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                    keyboardType: TextInputType.streetAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter vehicle number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: verify,
            child: Form(
              key: _regNameFormKey,
              child: Column(
                children: [
                  Text(
                    "Enter the name as in Registration certificate",
                    style: GoogleFonts.lemon(
                      color: Colors.indigo[200],
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: TextFormField(
                      controller: regNameEditCtrl,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        icon: Icon(
                          Icons.person_outline,
                          size: 20,
                        ),
                        labelText: 'Name in RC book',
                        hintText: "Full Name",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter a name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton.icon(
                color: Colors.indigo[800],
                label: Text(
                  "Cancel",
                  style: GoogleFonts.lemon(
                    color: Colors.indigo[50],
                    fontSize: 16,
                  ),
                ),
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              RaisedButton.icon(
                color: Colors.indigo[800],
                label: Text(
                  "Add Vehicle",
                  style: GoogleFonts.lemon(
                    color: Colors.indigo[50],
                    fontSize: 16,
                  ),
                ),
                icon: Icon(
                  Icons.wb_iridescent,
                  color: Colors.amber,
                ),
                onPressed: () async {
                  if (!verify) {
                    if (_vehicleNumFormKey.currentState.validate()) {
                      vehicle = await vehicleData
                          .checkVehicle(vehicleNumEditCtrl.text);

                      if (vehicle == null) return;

                      setState(() {
                        verify = true;
                      });
                    }
                  } else {
                    if (regNameEditCtrl.text.toLowerCase() !=
                        vehicle.name.toLowerCase()) {
                      showToast("Invalid Name");
                      return;
                    }
                    await vehicleData.saveVehicle(vehicle);
                    showToast("Vehicle added");
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
