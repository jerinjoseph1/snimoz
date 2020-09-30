import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snimoz/data/journey_data.dart';

class JourneysPage extends StatefulWidget {
  @override
  _JourneysPageState createState() => _JourneysPageState();
}

class _JourneysPageState extends State<JourneysPage> {
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
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    appBar(context),
                    myJourneys(journeyData),
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
            "My Journeys",
            style: GoogleFonts.pollerOne(
              color: Colors.indigo[50],
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget myJourneys(JourneyData journeyData) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          journeyData.journeyList.isEmpty
              ? Container(
                  width: double.infinity,
                  child: Text(
                    "No journeys found",
                    style: GoogleFonts.lemon(
                      color: Colors.indigo[200],
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: journeyData.journeyList.length,
                  itemBuilder: (_, i) {
                    int index = journeyData.journeyList.length - i - 1;
                    return Card(
                      color: Colors.indigo[700],
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        title: RichText(
                          text: TextSpan(
                            text:
                                "${journeyData.journeyList[index]["name"]} | ",
                            style: GoogleFonts.lemon(
                              color: Colors.indigo[100],
                              fontSize: 12,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: journeyData.journeyList[index]["mob"],
                                style: GoogleFonts.pollerOne(
                                  color: Colors.indigo[50],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vehicle Type: " +
                                  journeyData.journeyList[index]["vehicleType"],
                              style: GoogleFonts.lemon(
                                color: Colors.indigo[100],
                                fontSize: 9,
                              ),
                            ),
                            Text(
                              "Time in Utc: " +
                                  journeyData.journeyList[index]["time"],
                              style: GoogleFonts.lemon(
                                color: Colors.indigo[100],
                                fontSize: 9,
                              ),
                            ),
                            Text(
                              "lat: " +
                                  journeyData.journeyList[index]
                                      ["realtimeLocation"][0] +
                                  ",\tlong: " +
                                  journeyData.journeyList[index]
                                      ["realtimeLocation"][0],
                              style: GoogleFonts.lemon(
                                color: Colors.indigo[100],
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
        ],
      ),
    );
  }
}
