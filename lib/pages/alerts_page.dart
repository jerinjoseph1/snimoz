import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertsPage extends StatefulWidget {
  @override
  _AlertsPageState createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    appBar(context),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      "No Alerts Found",
                      style: TextStyle(color: Colors.indigo[100]),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FancyFab()
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
            "Alerts",
            style: GoogleFonts.pollerOne(
              color: Colors.indigo[50],
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
