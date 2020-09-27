import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snimoz/data/user_data.dart';
import 'package:snimoz/screens/bottom_nav_bar_screen.dart';
import 'package:snimoz/screens/loading_screen.dart';
import 'package:snimoz/screens/registration_screen.dart';

class AuthService {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return BottomNavBarScreen();
        } else if (!snapshot.hasData) {
          return RegistrationScreen();
        } else {
          return LoadingScreen();
        }
      },
    );
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential authCredential) {
    FirebaseAuth.instance.signInWithCredential(authCredential);
  }

  signInWithOTP(smsCode, verificationId) {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    signIn(authCredential);
  }
}
