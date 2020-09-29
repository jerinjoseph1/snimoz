import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snimoz/animation/animation.dart';
import 'package:snimoz/data/user_data.dart';
import 'package:snimoz/services/auth_service.dart';
import 'package:snimoz/utils/common_util.dart';

class RegistrationScreen extends StatelessWidget {
  final _regFormKey = GlobalKey<FormState>();
  final _smsFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserData userData = Provider.of<UserData>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
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
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      "Welcome to Snimoz",
                      style: GoogleFonts.righteous(
                        color: Colors.indigo[50],
                        fontSize: 35,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                    1.3,
                    Text(
                      "User Registration",
                      style: GoogleFonts.righteous(
                        color: Colors.indigo[50],
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.indigo[50],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                          1.4,
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.indigo[50],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.indigo[100],
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Form(
                              key: _regFormKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: TextFormField(
                                      initialValue:
                                          userData.userModel.name ?? "",
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.perm_identity,
                                          size: 20,
                                        ),
                                        labelText: 'Full Name',
                                      ),
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter your Name';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        userData.userModel.name = value;
                                        userData.codeSent = false;
                                      },
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        initialValue:
                                            userData.userModel.address ?? "",
                                        decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.location_city,
                                            size: 20,
                                          ),
                                          labelText: 'Resident Address',
                                        ),
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Enter address';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          userData.userModel.address = value;
                                          userData.codeSent = false;
                                        },
                                      )),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.phone,
                                          size: 20,
                                        ),
                                        prefixText: "+91",
                                        labelText: "Phone number",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter phone number';
                                        } else if (value.length != 10) {
                                          return 'Enter correct phone number';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        userData.userModel.phoneNumber = value;
                                        userData.codeSent = false;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Visibility(
                          visible: userData.codeSent,
                          child: FadeAnimation(
                            1.4,
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.indigo[50],
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.indigo[100],
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Form(
                                key: _smsFormKey,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  // maxLength: 6,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.sms,
                                      size: 20,
                                    ),
                                    labelText: "SMS Code",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter SMS code';
                                    } else if (value.length != 6) {
                                      return 'Enter correct SMS code';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    userData.smsCode = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                          1.6,
                          RaisedButton(
                            padding: EdgeInsets.fromLTRB(80, 17, 80, 17),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            color: Colors.indigo[800],
                            child: Text(
                              userData.codeSent ? "Verify OTP" : "Register",
                              style: GoogleFonts.righteous(
                                color: Colors.indigo[50],
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              switch (userData.codeSent) {
                                case true:
                                  if (_smsFormKey.currentState.validate()) {
                                    userData.storeUserData();
                                    AuthService().signInWithOTP(
                                      userData.smsCode,
                                      userData.verificationId,
                                    );
                                  }
                                  break;
                                default:
                                  if (_regFormKey.currentState.validate()) {
                                    verifyPhone(userData);
                                    userData.storeUserData();
                                  }
                                  break;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> verifyPhone(UserData userData) async {
    final PhoneVerificationCompleted phoneVerificationCompleted =
        (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException firebaseAuthException) {
      showToast('${firebaseAuthException.message}');
    };

    final PhoneCodeSent phoneCodeSent =
        (String verificationId, [int forceResend]) {
      userData.verificationId = verificationId;
      userData.codeSent = true;
    };

    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verId) {
      userData.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${userData.userModel.phoneNumber}',
      timeout: const Duration(seconds: 90),
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );
  }
}
