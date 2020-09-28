import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snimoz/animation/animation.dart';
import 'package:snimoz/data/licence_data.dart';
import 'package:snimoz/widgets/add_licence_widget.dart';

class LicenceVerificationPage extends StatefulWidget {
  @override
  _LicenceVerificationPageState createState() =>
      _LicenceVerificationPageState();
}

class _LicenceVerificationPageState extends State<LicenceVerificationPage> {
  void fetchLicenceData() {
    final LicenceData licenceData =
        Provider.of<LicenceData>(context, listen: false);
    licenceData.fetchLicence();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchLicenceData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final LicenceData licenceData = Provider.of<LicenceData>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.indigo[900],
              Colors.indigo[800],
              Colors.indigo[400]
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                appBar(context),
                FadeAnimation(
                  1.4,
                  licenceData.myLicence.number == null ||
                          licenceData.myLicence.number == ""
                      ? dashBoard(licenceData)
                      : myLicence(licenceData),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.indigo[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Licence Verification",
            style: GoogleFonts.pollerOne(
              color: Colors.indigo[50],
              fontSize: 22,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.indigo[100],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget dashBoard(LicenceData licenceData) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Card(
        elevation: 3,
        color: Colors.indigo[500],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add your licence to start a journey",
                style: GoogleFonts.lemon(
                  color: Colors.indigo[200],
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                      onPressed: () {
                        addLicenceSheet(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myLicence(LicenceData licenceData) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Card(
        color: Colors.indigo[700],
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          title: Text(
            "Licence No.: " + licenceData.myLicence.number,
            style: GoogleFonts.lemon(
              color: Colors.indigo[100],
              fontSize: 14,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name: " + licenceData.myLicence.name,
                style: GoogleFonts.lemon(
                  color: Colors.indigo[100],
                  fontSize: 13,
                ),
              ),
              Text(
                "DOB: " + licenceData.myLicence.dob,
                style: GoogleFonts.lemon(
                  color: Colors.indigo[100],
                  fontSize: 10,
                ),
              ),
              Text(
                "Validity: " + licenceData.myLicence.validity,
                style: GoogleFonts.lemon(
                  color: Colors.indigo[100],
                  fontSize: 10,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      "Vehicle Class: ",
                      style: GoogleFonts.lemon(
                        color: Colors.indigo[100],
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Wrap(
                      direction: Axis.vertical,
                      children: licenceData.myLicence.categories
                          .map(
                            (e) => Text(
                              e,
                              style: GoogleFonts.lemon(
                                color: Colors.indigo[100],
                                fontSize: 10,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete_sweep,
              color: Colors.red,
            ),
            onPressed: () {
              licenceData.deleteLicence();
            },
          ),
        ),
      ),
    );
  }
}
