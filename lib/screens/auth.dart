//import 'package:getting_started/constants/button.dart';
//import 'package:getting_started/constants/colors.dart';
//import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_navigation/src/routes/default_transitions.dart';
// import 'package:ble_Scanner/screens/blue_scan_anime.dart';
// import 'package:ble_Scanner/screens/firstpg.dart';
// import 'package:ble_Scanner/screens/bluetoothcontrol.dart';
// import 'package:swipeable_button_flutter/swipablewidget.dart';
// import 'package:swipeable_button_flutter/swipebutton.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:ble_Scanner/screens/home.dart';
// import 'package:ble_Scanner/controllers/bluetooth_controller.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   bool isFinished = false;

// // class AuthScreen extends StatelessWidget {
// //   const AuthScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("images/bgnoicon.png"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SafeArea(
//               child: Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 50.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Spacer(),
//                   Image.asset(
//                     "images/removebg.png",
//                     width: 300,
//                     //color: Color(0xFFc2ebaf),
//                     //alignment:,
//                     //height: 200,
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     "Test gigs",
//                     style: TextStyle(
//                       fontSize: 50,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     // style: GoogleFonts.lato(

//                     //   textStyle: Theme.of(context).textTheme.displayLarge,
//                     //   fontSize: 48,
//                     //   fontWeight: FontWeight.w700,
//                     //   fontStyle: FontStyle.italic,
//                     // ),
//                   ),
//                   Spacer(),
//                   ElevatedButton(
//                     // onPressed: () {
//                     //   Get.to(() => BlueControlpg());
//                     // },
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         PageTransition(
//                           child: BlueControlpg(),
//                           type: PageTransitionType.rightToLeft,
//                           duration: Duration(milliseconds: 500),
//                           reverseDuration: Duration(milliseconds: 500),
//                           //curve: Curves.ease))
//                         ),
//                       );
//                     },
//                     child: Text("START"),
//                     style: ElevatedButton.styleFrom(
//                       //backgroundColor: Color.fromARGB(255, 3, 23, 56),
//                       //foregroundColor: Colors.white,
//                       textStyle: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       //textStyle: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   Spacer(),
//                   //SizedBox(height: 90),

//                   // Row(
//                   //   children: [
//                   //     Text(
//                   //       "Powered by",
//                   //       //textAlign: TextAlign.right,
//                   //       style: TextStyle(
//                   //         color: Colors.white,
//                   //         fontSize: 30,
//                   //         fontWeight: FontWeight.bold,
//                   //       ),
//                   //     ),
//                   //   ],
//                   // ),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         "Powered by",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       //SizedBox(width: 5),
//                       Image.asset(
//                         'images/LogoSynobg.png', // Replace with your logo image path
//                         width: 100, // Adjust the width as needed
//                         height: 100,
//                         //color: , // Adjust the height as needed
//                       ),
//                       Text("    "),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )),
//         ],
//       ),
//     );
//   }
// }

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ble_Scanner/screens/blue_scan_anime.dart';
import 'package:ble_Scanner/screens/firstpg.dart';
import 'package:ble_Scanner/screens/bluetoothcontrol.dart';
import 'package:swipeable_button_flutter/swipablewidget.dart';
import 'package:swipeable_button_flutter/swipebutton.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ble_Scanner/screens/home.dart';
import 'package:ble_Scanner/controllers/bluetooth_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bgnoicon.png"),
                //image: AssetImage("images/secondpg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/removebg.png",
                  ),
                ),
                color: Colors.transparent,
                // borderRadius: BorderRadius.only(
                //   bottomRight: Radius.circular(5),
                //   topLeft: Radius.circular(5),
                // ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    SizedBox(height: 20),
                    Text(
                      "Test Jigs",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Let's get started!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                    ),
                    //Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: BlueControlpg(),
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 500),
                            reverseDuration: Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: Text("START"),
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          // Positioned widget to place the text and logo at the bottom right
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              children: [
                Text(
                  "Powered by",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //SizedBox(width: 5),
                Container(
                  //color: Colors.blue,
                  child: Image.asset(
                    'images/LogoSynobg.png', // Replace with your logo image path
                    width: 80, // Adjust the width as needed
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
