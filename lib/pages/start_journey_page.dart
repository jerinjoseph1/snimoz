import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snimoz/animation/animation.dart';
import 'package:snimoz/data/journey_data.dart';

class StartJourneyPage extends StatefulWidget {
  @override
  _StartJourneyPageState createState() => _StartJourneyPageState();
}

class _StartJourneyPageState extends State<StartJourneyPage> {
  @override
  Widget build(BuildContext context) {
    final JourneyData journeyData = Provider.of<JourneyData>(context);

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
                  dashBoard(journeyData),
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
            "Start A Journey",
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

  Widget dashBoard(JourneyData journeyData) {
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
                "Click here to start a journey",
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
                        "Start Journey",
                        style: GoogleFonts.lemon(
                          color: Colors.indigo[50],
                          fontSize: 16,
                        ),
                      ),
                      icon: Icon(
                        Icons.directions_car,
                        color: Colors.amber,
                      ),
                      onPressed: () {
                        // addLicenceSheet(context);
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
}
