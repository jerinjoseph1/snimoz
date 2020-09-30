import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snimoz/animation/animation.dart';
import 'package:snimoz/data/journey_data.dart';
import 'package:snimoz/data/licence_data.dart';
import 'package:snimoz/data/user_data.dart';
import 'package:snimoz/data/vehicle_data.dart';
import 'package:snimoz/models/entry_exit_point_model.dart';
import 'package:snimoz/models/vehicle_model.dart';
import 'package:snimoz/utils/common_util.dart';
import 'package:snimoz/widgets/add_licence_widget.dart';
import 'package:snimoz/widgets/add_vehicle_widget.dart';

class StartJourneyPage extends StatefulWidget {
  @override
  _StartJourneyPageState createState() => _StartJourneyPageState();
}

class _StartJourneyPageState extends State<StartJourneyPage> {
  final _startJourneyFormKey = GlobalKey<FormState>();
  StreamSubscription<Position> positionStream;
  StreamSubscription periodicSub;

  // StreamSubscription periodic;

  monitorSpeed() async {
    final JourneyData journeyData =
        Provider.of<JourneyData>(context, listen: false);
    final LicenceData licenceData =
        Provider.of<LicenceData>(context, listen: false);
    final UserData userData = Provider.of<UserData>(context, listen: false);
    journeyData.vehicle = null;
    journeyData.position = null;

    try {
      await getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      journeyData.speedList
        ..removeRange(0, journeyData.speedList.length - 1)
        ..add(0.0);

      // periodic = Stream.periodic(const Duration(seconds: 1))
      //     .take(24 * 60 * 360)
      //     .listen((_) async {
      //   Position position = await getCurrentPosition(
      //       desiredAccuracy: LocationAccuracy.bestForNavigation);
      //   if (position != null) {
      //     if (position.speed.runtimeType == double)
      //       journeyData.speedList.add(position.speed * 1.60934);
      //     if ((position.speed * 1.60934) > 20.0 && journeyData.showEndButton)
      //       journeyData.pushLocationViolation(
      //           userData.userModel, licenceData.myLicence);
      //     setState(() {});
      //   }
      // });

      positionStream = getPositionStream().listen((Position position) {
        if (position != null) {
          if (position.speed.runtimeType == double)
            journeyData.speedList.add(position.speed * 1.60934);
          if ((position.speed * 1.60934) > 20.0 && journeyData.showEndButton)
            journeyData.pushLocationViolation(
                userData.userModel, licenceData.myLicence);
          setState(() {});
        }
      });
      journeyData.position = await getCurrentPosition();
    } catch (e) {
      print(e);
    }
  }

  getEntryPoints() async {
    final JourneyData journeyData =
        Provider.of<JourneyData>(context, listen: false);
    await journeyData.getEntryExitPoints();
  }

  updater() async {
    final JourneyData journeyData =
        Provider.of<JourneyData>(context, listen: false);
    final LicenceData licenceData =
        Provider.of<LicenceData>(context, listen: false);
    final UserData userData = Provider.of<UserData>(context, listen: false);
    await journeyData.getRestrictedZones();
    periodicSub = Stream.periodic(const Duration(seconds: 10))
        .take(2 * 60 * 360)
        .listen((_) async {
      if (journeyData.showEndButton) {
        print('true');
        await journeyData.updateLocation();
        await journeyData.checkRestriction(
            userData.userModel, licenceData.myLicence);
        if (positionStream.isPaused) positionStream.resume();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      monitorSpeed();
      getEntryPoints();
      updater();
    });
  }

  @override
  void dispose() {
    if (positionStream != null) positionStream.cancel();
    if (periodicSub != null) periodicSub.cancel();
    // if (periodic != null) periodic.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final JourneyData journeyData = Provider.of<JourneyData>(context);
    final LicenceData licenceData = Provider.of<LicenceData>(context);
    final VehicleData vehicleData = Provider.of<VehicleData>(context);
    final UserData userData = Provider.of<UserData>(context);

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
                  !licenceData.hasLicence
                      ? addLicence(licenceData)
                      : !vehicleData.hasVehicle
                          ? addVehicle(vehicleData)
                          : Column(
                              children: [
                                speedCard(journeyData),
                                dashBoard(journeyData, licenceData, vehicleData,
                                    userData),
                              ],
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget speedCard(JourneyData journeyData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          flex: 3,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Sparkline(
              data: journeyData.speedList ?? [0.0],
              pointsMode: PointsMode.last,
              pointSize: 8.0,
              pointColor: Colors.amber,
              fillMode: FillMode.below,
              fillGradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.red[800], Colors.red[200]],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              journeyData.speedList.last.toStringAsFixed(2) + "Km/hr",
              style: GoogleFonts.lemon(
                color: Colors.indigo[50],
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
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

  Widget dashBoard(
    JourneyData journeyData,
    LicenceData licenceData,
    VehicleData vehicleData,
    UserData userData,
  ) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Card(
        elevation: 3,
        color: Colors.indigo[500],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _startJourneyFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !journeyData.showEndButton
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Complete the following to start a journey.\nYou can only start journey from starting destination.",
                            style: GoogleFonts.lemon(
                              color: Colors.indigo[200],
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Name: " + licenceData.myLicence.name,
                            style: TextStyle(
                              color: Colors.indigo[50],
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Licence No.: " + licenceData.myLicence.number,
                            style: TextStyle(
                              color: Colors.indigo[50],
                              fontSize: 14,
                            ),
                          ),
                          Theme(
                            data: ThemeData(
                              canvasColor: Colors.indigo,
                            ),
                            child: DropdownButtonFormField(
                              isExpanded: false,
                              hint: Text(
                                "Select a Vehicle",
                                style: TextStyle(
                                  color: Colors.indigo[200],
                                  fontSize: 14,
                                ),
                              ),
                              items: vehicleData.vehicles
                                  .map((VehicleModel v) => DropdownMenuItem(
                                        child: Text(
                                          "Vehicle No.: " + v.number,
                                          style: TextStyle(
                                            color: Colors.indigo[50],
                                            fontSize: 14,
                                          ),
                                        ),
                                        value: v,
                                      ))
                                  .toList(),
                              onChanged: (VehicleModel v) {
                                journeyData.vehicle = v;
                              },
                            ),
                          ),
                        ],
                      )
                    : Text(
                        "You can only end journey after reaching destination",
                        style: GoogleFonts.lemon(
                          color: Colors.indigo[200],
                          fontSize: 14,
                        ),
                      ),
                Theme(
                  data: ThemeData(
                    canvasColor: Colors.indigo,
                  ),
                  child: DropdownButtonFormField(
                    isExpanded: false,
                    hint: Text(
                      "Select a route",
                      style: TextStyle(
                        color: Colors.indigo[200],
                        fontSize: 14,
                      ),
                    ),
                    items: journeyData.listPoints
                        .map((EntryExitPointModel e) => DropdownMenuItem(
                              child: Text(
                                e.entryPointName + " to " + e.exitPointName,
                                style: TextStyle(
                                  color: Colors.indigo[50],
                                  fontSize: 14,
                                ),
                              ),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (EntryExitPointModel e) {
                      journeyData.entryPoint = e;
                    },
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
                        color: journeyData.showEndButton
                            ? Colors.red
                            : Colors.indigo[800],
                        label: Text(
                          journeyData.showEndButton
                              ? "End Journey"
                              : "Start Journey",
                          style: GoogleFonts.lemon(
                            color: Colors.indigo[50],
                            fontSize: 16,
                          ),
                        ),
                        icon: Icon(
                          Icons.directions_car,
                          color: Colors.amber,
                        ),
                        onPressed: () async {
                          if (journeyData.showEndButton) {
                            journeyData.position = await getCurrentPosition();
                            double distanceInMeters = distanceBetween(
                                double.parse(
                                    journeyData.entryPoint.exitPointLat),
                                double.parse(
                                    journeyData.entryPoint.exitPointLng),
                                journeyData.position.latitude,
                                journeyData.position.longitude);
                            if (distanceInMeters < 1000) {
                              await journeyData.endJourney(
                                  userData.userModel, licenceData.myLicence);
                              Navigator.pop(context);
                            } else
                              showToast("Cannot end journey");
                          } else if (journeyData.vehicle == null) {
                            showToast("Select a vehicle");
                            return;
                          } else if (journeyData.entryPoint == null) {
                            showToast("Select a route");
                            return;
                          } else if (journeyData.position == null) {
                            showToast("Turn on location permission");
                            return;
                          } else {
                            double distanceInMeters = distanceBetween(
                                double.parse(
                                    journeyData.entryPoint.entryPointLat),
                                double.parse(
                                    journeyData.entryPoint.entryPointLng),
                                journeyData.position.latitude,
                                journeyData.position.longitude);

                            if (distanceInMeters < 1000)
                              journeyData.addJourney(
                                  userData.userModel, licenceData.myLicence);
                            else
                              showToast("Cannot start journey");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addLicence(LicenceData licenceData) {
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

  Widget addVehicle(VehicleData vehicleData) {
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
                "Add your vehicle here to start a journey\nYou can only select the vehicles added here",
                style: GoogleFonts.lemon(
                  color: Colors.indigo[200],
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                      onPressed: () {
                        addVehicleSheet(context);
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
