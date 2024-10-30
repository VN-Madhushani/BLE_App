import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:ble_Scanner/controllers/bluetooth_controller.dart';
import 'package:ble_Scanner/constants/colors.dart';
import 'package:ble_Scanner/widgets/device_list_item.dart';

class Firstpg extends StatelessWidget {
  Firstpg({Key? key}) : super(key: key);

  //bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("BLE SCANNER"),
        // ),
        body: GetBuilder<BluetoothController>(
            init: BluetoothController(),
            builder: (controller) {
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: ElevatedButton(
                            //onPressed: () {},
                            //onPressed: () => controller.scanDevices(),
                            onPressed: () async {
                              controller.scanDevices();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: backgroundCOlor,
                              minimumSize: const Size(350, 55),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                            child: const Text(
                              "Scan",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      StreamBuilder<List<ScanResult>>(
                          stream: controller.scanResults,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final data = snapshot.data![index];

                                    return DeviceListItem(
                                      device: data,
                                      onConnectPressed: (device) async {
                                        print(
                                            'Connect pressed for: ${device.name.isNotEmpty ? device.name : 'Unknown Device'}');
                                        await controller
                                            .connectToDevice(device);
                                      },
                                    );
                                  });
                            } else {
                              return const Center(
                                child: Text("No devices found"),
                              );
                            }
                          })
                    ],
                  ),
                ),
              );
            }));
  }
}
