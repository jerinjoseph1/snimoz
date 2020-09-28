import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snimoz/data/journey_data.dart';
import 'package:snimoz/data/licence_data.dart';
import 'package:snimoz/data/vehicle_data.dart';
import 'package:snimoz/data/user_data.dart';
import 'package:snimoz/data/wallet_data.dart';
import 'package:snimoz/screens/bottom_nav_bar_screen.dart';
import 'package:snimoz/screens/loading_screen.dart';
import 'package:snimoz/screens/registration_screen.dart';
import 'package:snimoz/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserData>(create: (_) => UserData()),
        ChangeNotifierProvider<WalletData>(create: (_) => WalletData()),
        ChangeNotifierProvider<VehicleData>(create: (_) => VehicleData()),
        ChangeNotifierProvider<LicenceData>(create: (_) => LicenceData()),
        ChangeNotifierProvider<JourneyData>(create: (_) => JourneyData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Snimoz',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          canvasColor: Colors.indigo[50],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => AuthService().handleAuth(),
          '/loading_screen': (context) => LoadingScreen(),
          '/bottom_nav_bar_screen': (context) => BottomNavBarScreen(),
          '/registration_screen': (context) => RegistrationScreen(),
        },
      ),
    );
  }
}
