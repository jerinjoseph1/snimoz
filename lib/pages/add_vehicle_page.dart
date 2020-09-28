import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snimoz/data/vehicle_data.dart';
import 'package:snimoz/widgets/add_vehicle_widget.dart';

class AddVehiclePage extends StatefulWidget {
  @override
  _AddVehiclePageState createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  void fetchVehicles() {
    final VehicleData vehicleData =
        Provider.of<VehicleData>(context, listen: false);
    vehicleData.fetchVehicles();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchVehicles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final VehicleData vehicleData = Provider.of<VehicleData>(context);
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
                dashBoard(vehicleData),
                myVehicles(vehicleData),
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
            "Add Vehicles",
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

  Widget dashBoard(VehicleData vehicleData) {
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

  Widget myVehicles(VehicleData vehicleData) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My Vehicles",
            style: GoogleFonts.lemon(
              color: Colors.indigo[50],
              fontSize: 16,
            ),
          ),
          SizedBox(height: 15),
          vehicleData.vehicles.isEmpty
              ? Container(
                  width: double.infinity,
                  child: Text(
                    "No vehicles found",
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
                  itemCount: vehicleData.vehicles.length,
                  itemBuilder: (_, i) {
                    int index = vehicleData.vehicles.length - i - 1;
                    return Card(
                      color: Colors.indigo[700],
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        title: RichText(
                          text: TextSpan(
                            text: "${vehicleData.vehicles[index].model} | ",
                            style: GoogleFonts.lemon(
                              color: Colors.indigo[100],
                              fontSize: 12,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: vehicleData.vehicles[index].number,
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
                              "Owner Name: " + vehicleData.vehicles[index].name,
                              style: GoogleFonts.lemon(
                                color: Colors.indigo[100],
                                fontSize: 9,
                              ),
                            ),
                            Text(
                              "Vehicle Type: " +
                                  vehicleData.vehicles[index].type,
                              style: GoogleFonts.lemon(
                                color: Colors.indigo[100],
                                fontSize: 9,
                              ),
                            ),
                            Text(
                              "Vehicle Color: " +
                                  vehicleData.vehicles[index].color,
                              style: GoogleFonts.lemon(
                                color: Colors.indigo[100],
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete_sweep,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            vehicleData
                                .deleteVehicle(vehicleData.vehicles[index]);
                          },
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
