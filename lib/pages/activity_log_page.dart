// import 'package:flutter/material.dart';
// import 'package:snimoz/helpers/activity_log.dart';
// import 'package:snimoz/models/avtivity_log_models.dart';
//
// class ActivityLogPage extends StatefulWidget {
//   @override
//   _ActivityLogPageState createState() => _ActivityLogPageState();
// }
//
// class _ActivityLogPageState extends State<ActivityLogPage> {
//   List<ActivityLog> activityLog = new List();
//
//   @override
//   void initState() {
//     DatabaseHelper.instance.queryAllRows().then((value) {
//       setState(() {
//         value.forEach((element) {
//           activityLog.add(
//             ActivityLog(
//               id: element['id'],
//               name: element["name"],
//               region1: element["region1"],
//               region2: element["region2"],
//               vehicleNum: element["vehicleNum"],
//             ),
//           );
//         });
//       });
//     }).catchError((error) {
//       print(error);
//     });
//     super.initState();
//   }
//
//   void _deleteTask(int id) async {
//     await DatabaseHelper.instance.delete(id);
//     setState(() {
//       activityLog.removeWhere((element) => element.id == id);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Journey Logs"),
//         backgroundColor: Colors.indigo[800],
//       ),
//       body: SafeArea(
//         child: Expanded(
//           child: Container(
//             child: activityLog.isEmpty
//                 ? Container()
//                 : ListView.builder(itemBuilder: (ctx, index) {
//                     if (index == activityLog.length) return null;
//                     return Card(
//                       child: ListTile(
//                         title: Padding(
//                           padding: const EdgeInsets.only(top: 10.0),
//                           child: Text(
//                             "Name  " + activityLog[index].name.toString(),
//                             style: TextStyle(
//                                 color: Colors.grey[400],
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         subtitle: Padding(
//                           padding: const EdgeInsets.only(bottom: 20.0, top: 10),
//                           child: Text("region 1   :" +
//                               activityLog[index].region1.toString()),
//                         ),
//                         leading: Text(activityLog[index].id.toString()),
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () => _deleteTask(activityLog[index].id),
//                         ),
//                       ),
//                     );
//                   }),
//           ),
//         ),
//       ),
//     );
//   }
// }
