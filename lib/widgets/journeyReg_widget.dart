import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;




//
// Widget JourneyReg(String userName, String userAddress, String userVehicleNum,
//     String phoneNum, String region1, String  region2) {
//   final name = TextEditingController(text: userName);
//   final address = TextEditingController(text: userAddress);
//   final vehicleNumber = TextEditingController(text: userVehicleNum);
//   final phoneNumber = TextEditingController(text: phoneNum);
//   final regions1 = TextEditingController(text: region1);
//   final regions2 = TextEditingController(text: region2);
//   final vehicleType = TextEditingController( );
//
//
//   Future<http.Response> registerJourney() {
//     return http.post(
//       'https://snimoz-api.herokuapp.com/journeyRegistration',
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'name': name.text,
//         'mob': phoneNumber.text,
//         'vehicleReg': vehicleNumber.text,
//         'vehicleType': vehicleType.text,
//         'time': name.text,
//       }),
//     );
//   }
//   return Column(
//
//     children: [
//       new Theme(
//         data: new ThemeData(
//           primaryColor: Colors.indigo,
//           primaryColorDark: Colors.red,
//         ),
//         child: new TextField(
//           controller: name,
//           decoration: new InputDecoration(
//               border: new OutlineInputBorder(
//                   borderSide: new BorderSide(color: Colors.teal)),
//               hintText: 'Enter your name',
//               helperText: '',
//               labelText: 'Name',
//               prefixIcon: const Icon(
//                 Icons.person,
//                 color: Colors.green,
//               ),
//             ),
//         ),
//       ),
//       new Theme(
//         data: new ThemeData(
//           primaryColor: Colors.indigo,
//           primaryColorDark: Colors.red,
//         ),
//         child: new TextField(
//           controller: address,
//           decoration: new InputDecoration(
//             border: new OutlineInputBorder(
//                 borderSide: new BorderSide(color: Colors.teal)),
//             hintText: 'Enter your address',
//             helperText: '',
//             labelText: 'Address',
//             prefixIcon: const Icon(
//               Icons.home,
//               color: Colors.green,
//             ),
//           ),
//         ),
//       ),
//       new Theme(
//         data: new ThemeData(
//           primaryColor: Colors.indigo,
//           primaryColorDark: Colors.red,
//         ),
//         child: new TextField(
//           controller: vehicleNumber,
//           decoration: new InputDecoration(
//             border: new OutlineInputBorder(
//                 borderSide: new BorderSide(color: Colors.teal)),
//             hintText: 'Enter your Vehicle Number',
//             helperText: '',
//             labelText: 'Vehicle Number',
//             prefixIcon: const Icon(
//               Icons.directions_car,
//               color: Colors.green,
//             ),
//           ),
//         ),
//       ),
//
//       new Theme(
//         data: new ThemeData(
//           primaryColor: Colors.indigo,
//           primaryColorDark: Colors.red,
//         ),
//         child: new TextField(
//           controller: vehicleType,
//           decoration: new InputDecoration(
//             border: new OutlineInputBorder(
//                 borderSide: new BorderSide(color: Colors.teal)),
//             hintText: 'Enter your Vehicle Type',
//             helperText: '',
//             labelText: 'Vehicle Type',
//             prefixIcon: const Icon(
//               Icons.menu,
//               color: Colors.green,
//             ),
//           ),
//         ),
//       ),
//       new Theme(
//         data: new ThemeData(
//           primaryColor: Colors.indigo,
//           primaryColorDark: Colors.red,
//         ),
//         child: new TextField(
//           controller: phoneNumber,
//           decoration: new InputDecoration(
//             border: new OutlineInputBorder(
//                 borderSide: new BorderSide(color: Colors.teal)),
//             hintText: 'Enter your Phone Number',
//             helperText: '',
//             labelText: 'Phone Number',
//             prefixIcon: const Icon(
//               Icons.phone,
//               color: Colors.green,
//             ),
//           ),
//         ),
//       ),
//
//       Card(
//         shadowColor: Colors.indigo[200],
//         elevation: 3,
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             children: [      new Theme(
//               data: new ThemeData(
//                 primaryColor: Colors.indigo,
//                 primaryColorDark: Colors.red,
//               ),
//               child: new TextField(
//                 controller: regions1,
//                 decoration: new InputDecoration(
//                   border: new OutlineInputBorder(
//                       borderSide: new BorderSide(color: Colors.teal)),
//                   hintText: 'Enter your Phone Number',
//                   helperText: '',
//                   labelText: 'Regions 1',
//                   prefixIcon: const Icon(
//                     Icons.location_on,
//                     color: Colors.green,
//                   ),
//                 ),
//               ),
//             ),
//               new Theme(
//                 data: new ThemeData(
//                   primaryColor: Colors.indigo,
//                   primaryColorDark: Colors.red,
//                 ),
//                 child: new TextField(
//                   controller: regions2,
//                   decoration: new InputDecoration(
//                     border: new OutlineInputBorder(
//                         borderSide: new BorderSide(color: Colors.teal)),
//                     hintText: 'Enter your Phone Number',
//                     helperText: '',
//                     labelText: 'Region 2',
//                     prefixIcon: const Icon(
//                       Icons.location_on,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ),
//               ),],
//           ),
//         ),
//       ),
//
//
//
//       FlatButton.icon(onPressed: (){registerJourney();}, icon: Icon(Icons.file_upload), label: Text("REGISTER",  style: GoogleFonts.poppins(
//         textStyle: TextStyle(color: Colors.green, fontSize: 19,),
//       ),))
//     ],
//   );
// }
