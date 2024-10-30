import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:ble_Scanner/screens/firstpg.dart';
import 'package:ble_Scanner/utils/utils.dart';
import 'package:ble_Scanner/widgets/devicehome.dart';
import 'package:ble_Scanner/models/common_data_response.dart';
import 'package:ble_Scanner/models/common_response.dart';

class BluetoothController extends GetxController {
  //FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  FlutterBluePlus flutterBlue = FlutterBluePlus();

  //isScanning is a  reactive variable,boolean false is converted to an observable
  RxBool isScanning = false.obs;
  RxBool isBluetoothOn = false.obs;

  // Map to keep track of device connection states
  //RxMap<String, bool> deviceConnectionStates = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    checkBluetoothState();

    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      if (state == BluetoothAdapterState.on) {
        isBluetoothOn.value = true;
        //Get.to(() => Firstpg());
      } else {
        isBluetoothOn.value = false;
      }
    });
  }

  Future<void> checkBluetoothState() async {
    try {
      if (await FlutterBluePlus.isSupported == false) {
        print("Bluetooth not supported by this device");
        return;
      }

      // var subscription =
      //     FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      //   print(state);
      //   if (state == BluetoothAdapterState.on) {
      //     // usually start scanning, connecting, etc
      //     Get.to(() => Firstpg());
      //   } else {
      //     // show an error to the user, etc
      //     print("Bluetooth is not on");
      //   }
      // });

      bool isOn = await FlutterBluePlus.isOn;
      isBluetoothOn.value = isOn;

      print("BLE status:**********");
      print(isOn);

      // if (isOn) {
      //   Get.to(() => Firstpg());
      // }

      //subscription.cancel();
    } catch (e) {
      print("Error checking ble state:$e");
    }
  }

  Future scanDevices() async {
    print(isScanning.value);

    if (isScanning.value) {
      return;
    }

    bool a = await FlutterBluePlus.isOn;
    print(a);

    isScanning.value = true;
    print("Start scanning");
    //start scan for 5 sec

    var subscription = FlutterBluePlus.onScanResults.listen(
      (results) {
        if (results.isNotEmpty) {
          ScanResult r = results.last; // the most recently found device

          // var waveTechDevices = results
          //     .where((result) =>
          //         result.advertisementData.advName != null &&
          //         result.advertisementData.advName.startsWith('WaveTech'))
          //     .toList();

          // for (var device in waveTechDevices) {
          //   print(
          //       '${device.device.remoteId}: "${device.advertisementData.advName}" found!');
          // }

          print(
              '${r.device.remoteId}: "${r.advertisementData.advName}" found!');
        }
      },
      onError: (e) => print(e),
    );

    print("Start scannning 2");

    await FlutterBluePlus.startScan(
        withKeywords: const ["WaveTec"], timeout: const Duration(seconds: 10));
    //await FlutterBluePlus.stopScan();
    // FlutterBluePlus.stopScan();
    isScanning.value = false;
    print("Stop scanning");
    subscription.cancel();
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  //to get the connectionstate
  Stream<BluetoothConnectionState> getConnectionStateStream(
      BluetoothDevice device) {
    return device.connectionState;
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      // Listen for connection state changes
      var subscription =
          device.connectionState.listen((BluetoothConnectionState state) async {
        if (state == BluetoothConnectionState.disconnected) {
          // Handle disconnection
          //deviceConnectionStates[device.remoteId.toString()] = false;
          //print("${device.disconnectReasonCode} ${device.disconnectReasonDescription}");
          print("disconnection occur");
          //Get.to(() => Firstpg());
        }
      });

      // Cleanup: cancel subscription when disconnected
      device.cancelWhenDisconnected(subscription, delayed: true, next: true);

      // Connect to the device
      await device.connect();
      print('Connected to the device');

      //deviceConnectionStates[device.remoteId.toString()] = true;

      // Disconnect from the device when done
      //await device.disconnect();
      //print('Disconnected from the device');

      Get.to(() => DeviceHomePage(device: device));

      //subscription.cancel();
    } catch (e) {
      print('Error connecting to the device: $e');
      //subscription?.cancel();
    }
  }

  Future<void> disconnectDevice(BluetoothDevice device) async {
    try {
      await device.disconnect();
      print('Disconnected the device');
      Get.back();
    } catch (e) {
      print('Error disconnecting the device: $e');
    }
  }

  Future<CommonDataResponse> readUserDetails(BluetoothDevice device) async {
    CommonResponse commonResponse = await readUserDetailsRequest(device);
    if (commonResponse.state == "S100") {
      await Future.delayed(Duration(seconds: 3));
      CommonDataResponse commonDataResponse =
          await readUserDetailsResponse(device);
      print(commonDataResponse.toJson());
      print("response**************");
      print(commonDataResponse);
      // {state: S100, stateDescription: Success, data: 26x2R1,'SSID1', 'pwd1'}
      return commonDataResponse;
    } else {
      return CommonDataResponse.fromDetails(
        commonResponse.state,
        commonResponse.stateDescription,
      );
    }
  }

  Future<bool> write(BluetoothDevice device, List<int> data, String ServiceUUID,
      String charUUID) async {
    bool response = false;
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        if (service.uuid.toString() == ServiceUUID) {
          for (var element in service.characteristics) {
            if (element.uuid.toString() == charUUID) {
              await element
                  .write(
                    data,
                  )
                  .then((value) => response = true)
                  .onError((error, stackTrace) {
                response = false;
                return response;
              });
              print("done");
            }
          }
        }
      }
    } catch (e) {
      return response;
    }
    return response;
  }

  Future<String?> read(
      BluetoothDevice device, String ServiceUUID, String charUUID) async {
    String? response = null;
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        if (service.uuid.toString() == ServiceUUID) {
          for (var element in service.characteristics) {
            if (element.uuid.toString() == charUUID) {
              List<int> value = await element.read();
              print(value);
              String? valueString = Utils.resultToSting(value);
              response = valueString;
              if (valueString!.isEmpty) {
                return null;
              }
            }
          }
        }
      }
    } catch (e) {
      return response;
    }
    return response;
  }

  Future<CommonResponse> readUserDetailsRequest(BluetoothDevice device) async {
    bool response = await write(
      device,
      Utils.convertStringToByte("10"),
      "1001",
      "f0001002-0451-4000-b000-000000000000",
    );

    if (response) {
      return CommonResponse.fromDetails(
        "S100",
        "Success",
      );
    } else {
      return CommonResponse.fromDetails(
        "E100",
        "Read user details request failed",
      );
    }
  }

  Future<CommonDataResponse> readUserDetailsResponse(
      BluetoothDevice device) async {
    String? stringResponse = await read(
      device,
      "1001",
      "f0001003-0451-4000-b000-000000000000",
    );
    //26x2R1,'SSID1', 'pwd1'

    if (stringResponse == null) {
      return CommonDataResponse.fromDetails(
        "E100",
        "Did't receive user details",
      );
    } else {
      // convert string response to model
      return CommonDataResponse.fromDetails(
        "S100",
        "Success",
        data: stringResponse,
      );
    }
  }

  Future<CommonResponse> writeUserDetails(
    BluetoothDevice device,
    String data,
  ) async {
    bool response = await write(
      device,
      Utils.convertStringToByte(data),
      "1001",
      "f0001004-0451-4000-b000-000000000000",
    );

    if (response) {
      return CommonResponse.fromDetails(
        "S100",
        "Success",
      );
    } else {
      return CommonResponse.fromDetails(
        "E100",
        "Failed to write user details",
      );
    }
  }
}
