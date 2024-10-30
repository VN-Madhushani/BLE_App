import 'dart:ffi';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ble_Scanner/controllers/bluetooth_controller.dart';
import 'package:ble_Scanner/screens/firstpg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ble_Scanner/controllers/bluetooth_controller.dart';
import 'package:ble_Scanner/screens/firstpg.dart';
import 'package:page_transition/page_transition.dart';

class BlueControlpg extends StatelessWidget {
  BlueControlpg({Key? key}) : super(key: key);

  final BluetoothController bluetoothController =
      Get.find<BluetoothController>();

  @override
  Widget build(BuildContext context) {
    bluetoothController.checkBluetoothState();
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/secondpg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Bluetooth Icon
                Obx(() {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 10),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: bluetoothController.isBluetoothOn.value
                        ? Icon(
                            Icons.bluetooth,
                            key: ValueKey<bool>(
                                bluetoothController.isBluetoothOn.value),
                            size: 300,
                            color: Colors.blue,
                          )
                        : Icon(
                            Icons.bluetooth_disabled,
                            key: ValueKey<bool>(
                                bluetoothController.isBluetoothOn.value),
                            size: 300,
                            color: Colors.red,
                          ),
                  );
                }),

                SizedBox(height: 100),
                Obx(() {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: bluetoothController.isBluetoothOn.value
                            ? () {
                                //Get.to(() => Firstpg());
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: Firstpg(),
                                    type: PageTransitionType.topToBottom,
                                    duration: Duration(milliseconds: 500),
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    childCurrent: this,
                                  ),
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              bluetoothController.isBluetoothOn.value
                                  ? Colors.blue
                                  : Colors.grey,
                        ),
                        child: Text(
                          "NEXT",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      SizedBox(height: 10),
                      if (!bluetoothController.isBluetoothOn.value)
                        Text(
                          'Turn Bluetooth ON',
                          style: TextStyle(color: Colors.red, fontSize: 25),
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
