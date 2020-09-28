import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snimoz/data/licence_data.dart';

void addLicenceSheet(BuildContext context) async {
  showModalBottomSheet(
    backgroundColor: Colors.indigo[50],
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    context: context,
    builder: (_) {
      return AddLicenceSheet();
    },
  );
}

class AddLicenceSheet extends StatefulWidget {
  @override
  _AddLicenceSheetState createState() => _AddLicenceSheetState();
}

class _AddLicenceSheetState extends State<AddLicenceSheet> {
  final _licenseFormKey = GlobalKey<FormState>();
  final TextEditingController licenseNumEditCtrl = TextEditingController();
  final TextEditingController licenceNameEditCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LicenceData licenceData = Provider.of<LicenceData>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _licenseFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: licenseNumEditCtrl,
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
                    labelText: 'Licence Number',
                    hintText: "XX-xx-xxxxxxxxxxx",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter licence number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Enter the name as in your Licence",
                  style: GoogleFonts.lemon(
                    color: Colors.indigo[200],
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: licenceNameEditCtrl,
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
              ],
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
                  "Add Licence",
                  style: GoogleFonts.lemon(
                    color: Colors.indigo[50],
                    fontSize: 16,
                  ),
                ),
                icon: Icon(
                  Icons.class_,
                  color: Colors.amber,
                ),
                onPressed: () async {
                  if (_licenseFormKey.currentState.validate()) {
                    await licenceData.addLicence(
                        licenseNumEditCtrl.text, licenceNameEditCtrl.text);
                  }
                  Navigator.pop(context);
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
