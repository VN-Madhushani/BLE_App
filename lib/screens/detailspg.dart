// import 'package:flutter/material.dart';
// import 'package:ble_Scanner/models/todo.dart';
// import 'package:ble_Scanner/constants/colors.dart';

// class Detailspg extends StatelessWidget {
//   final ToDo todo;

//   const Detailspg({
//     Key? key,
//     required this.todo,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Details",
//           style: TextStyle(
//               fontSize: 30, fontWeight: FontWeight.w500, color: tdBlack),
//         ),
//         backgroundColor: tdBGColor,
//       ),
//       backgroundColor: tdBGColor,
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Table(
//           columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
//           children: [
//             TableRow(
//               children: [
//                 TableCell(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: Text(
//                       'ID:',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: tdBlack),
//                     ),
//                   ),
//                 ),
//                 TableCell(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: Text(
//                       '${todo.id}',
//                       style: TextStyle(fontSize: 20, color: tdGrey),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             TableRow(
//               children: [
//                 TableCell(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: Text(
//                       'ToDo Text:',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: tdBlack),
//                     ),
//                   ),
//                 ),
//                 TableCell(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: Text(
//                       '${todo.todoText}',
//                       style: TextStyle(fontSize: 20, color: tdGrey),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             TableRow(
//               children: [
//                 TableCell(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: Text(
//                       'Is Done:',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: tdBlack),
//                     ),
//                   ),
//                 ),
//                 TableCell(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.0),
//                     child: Text(
//                       '${todo.isdone ? 'Yes' : 'No'}',
//                       style: TextStyle(fontSize: 20, color: tdGrey),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
