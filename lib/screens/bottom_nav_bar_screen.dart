import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snimoz/data/journey_data.dart';
import 'package:snimoz/data/licence_data.dart';
import 'package:snimoz/data/user_data.dart';
import 'package:snimoz/data/vehicle_data.dart';
import 'package:snimoz/pages/home_page.dart';
import 'package:snimoz/pages/alerts_page.dart';
import 'package:snimoz/pages/journeys_page.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int currentTabIndex = 0;
  List<Widget> tabs = [
    HomePage(),
    JourneysPage(),
    AlertsPage(),
  ];

  void fetchData() {
    final UserData userData = Provider.of<UserData>(context, listen: false);
    final LicenceData licenceData =
        Provider.of<LicenceData>(context, listen: false);
    final VehicleData vehicleData =
        Provider.of<VehicleData>(context, listen: false);
    userData.fetchUserData();
    licenceData.fetchLicence();
    vehicleData.fetchVehicles();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.indigo[900],
          selectedItemBorderColor: Colors.indigo[900],
          selectedItemBackgroundColor: Colors.indigo[100],
          selectedItemIconColor: Colors.indigo[900],
          selectedItemLabelColor: Colors.indigo[100],
          unselectedItemIconColor: Colors.indigo[200],
          unselectedItemLabelColor: Colors.indigo[200],
        ),
        selectedIndex: currentTabIndex,
        onSelectTab: (index) {
          if (index != currentTabIndex) HapticFeedback.lightImpact();
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.home,
            label: 'Home',
          ),
          FFNavigationBarItem(
            iconData: Icons.map,
            label: 'Journeys',
          ),
          FFNavigationBarItem(
            iconData: Icons.notifications,
            label: 'Alerts',
          ),
        ],
      ),
    );
  }
}
