import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snimoz/animation/animation.dart';
import 'package:snimoz/data/user_data.dart';
import 'package:snimoz/pages/add_vehicle_page.dart';
import 'package:snimoz/pages/start_journey_page.dart';
import 'package:snimoz/pages/licence_page.dart';
import 'package:snimoz/pages/wallet_page.dart';
import 'package:snimoz/services/auth_service.dart';

class HomePage extends StatelessWidget {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(context),
              SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.4,
                      walletCard(context),
                    ),
                    FadeAnimation(
                      1.8,
                      startJourneyCard(context),
                    ),
                    FadeAnimation(
                      2.2,
                      addVehicle(context),
                    ),
                    FadeAnimation(
                      2.6,
                      verifyLicense(context),
                    ),
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
            "Home",
            style: GoogleFonts.pollerOne(
              color: Colors.indigo[50],
              fontSize: 22,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.indigo[50],
            ),
            onPressed: () {
              final UserData userData =
                  Provider.of<UserData>(context, listen: false);
              userData.codeSent = false;
              AuthService().signOut();
            },
          ),
        ],
      ),
    );
  }

  Widget walletCard(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        elevation: 3,
        color: Colors.indigo[500],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.indigo[100],
                  size: 30,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My Wallet",
                      style: GoogleFonts.lemon(
                        color: Colors.indigo[50],
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Recharge with ₹200 (minimum) to start journey",
                      style: GoogleFonts.lemon(
                        color: Colors.indigo[200],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WalletPage(),
          ),
        );
      },
    );
  }

  Widget startJourneyCard(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        elevation: 3,
        color: Colors.indigo[600],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.directions_car,
                  color: Colors.indigo[100],
                  size: 30,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start Journey",
                      style: GoogleFonts.lemon(
                        color: Colors.indigo[50],
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Start a new journey by clicking here",
                      style: GoogleFonts.lemon(
                        color: Colors.indigo[200],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StartJourneyPage(),
          ),
        );
      },
    );
  }

  Widget addVehicle(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        elevation: 3,
        color: Colors.indigo[700],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.wb_iridescent,
                  color: Colors.indigo[100],
                  size: 30,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Vehicle",
                      style: GoogleFonts.lemon(
                        color: Colors.indigo[50],
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Verify your vehicle here before starting a journey",
                      style: GoogleFonts.lemon(
                        color: Colors.indigo[200],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddVehiclePage(),
          ),
        );
      },
    );
  }

  Widget verifyLicense(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        elevation: 3,
        color: Colors.indigo[700],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.class_,
                  color: Colors.indigo[100],
                  size: 30,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Verify License",
                      style: GoogleFonts.lemon(
                        color: Colors.indigo[50],
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Verify license before starting a new journey",
                      style: GoogleFonts.lemon(
                        color: Colors.indigo[200],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LicenceVerificationPage(),
          ),
        );
      },
    );
  }
}
