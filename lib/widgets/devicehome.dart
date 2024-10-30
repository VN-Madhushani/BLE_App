/*

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:ble_Scanner/controllers/bluetooth_controller.dart';
import 'package:ble_Scanner/screens/firstpg.dart';
import 'package:ble_Scanner/models/common_data_response.dart';
import 'package:ble_Scanner/models/common_response.dart';
import 'package:ble_Scanner/utils/utils.dart';

class DeviceHomePage extends StatefulWidget {
  final BluetoothDevice device;
  final BluetoothController bluetoothController =
      BluetoothController(); // Instantiate BluetoothController

  DeviceHomePage({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  _DeviceHomePageState createState() => _DeviceHomePageState();
}

class _DeviceHomePageState extends State<DeviceHomePage> {
  String ssid = '';
  String password = '';
  String status = 'Disconnected'; // Default status
  //String status = '';

  final TextEditingController ssidController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _showSettings =
      false; // Control the visibility of SSID and password input fields
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _listenToConnectionState(); //new
    _readUserDetails();
  }

  @override
  void dispose() {
    ssidController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _readUserDetails() async {
    BluetoothController bluetoothController = Get.find();
    CommonDataResponse commonDataResponse =
        await bluetoothController.readUserDetails(widget.device);

    if (mounted) {
      if (commonDataResponse.state == "S100") {
        String data = commonDataResponse.data;
        List<String> dataList = data.split(':');
        setState(() {
          ssid = dataList[0];
          password = dataList[1];
        });
      } else {
        print(commonDataResponse.stateDescription);
      }
    }
  }

  Future<void> _writeUserDetails() async {
    String newssid = ssidController.text;
    String newPassword = passwordController.text;
    String combinedData = '$newssid:$newPassword';

    print(combinedData);
    print(Utils.convertStringToByte(combinedData));

    BluetoothController bluetoothController = Get.find();
    CommonResponse commonResponse =
        await bluetoothController.writeUserDetails(widget.device, combinedData);

    if (mounted) {
      if (commonResponse.state == 'S100') {
        print("Write success");
        _readUserDetails();
        _showSuccessSnackbar(context);
      } else {
        print('write failed:${commonResponse.stateDescription}');
      }
    }
  }

  void _listenToConnectionState() {
    widget.bluetoothController
        .getConnectionStateStream(widget.device)
        .listen((BluetoothConnectionState state) {
      setState(() {
        status = state == BluetoothConnectionState.connected
            ? 'Connected'
            : 'Disconnected';
      });
    });
  }

  void _showSuccessSnackbar(BuildContext context) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changes saved successfully.'),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 200),
        ),
      );
    }
  }

  void _showErrorSnackbar(BuildContext context, String errorMessage) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changes failed to save.: $errorMessage'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _toggleSettings() {
    setState(() {
      _showSettings = !_showSettings;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/secondpg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Text(
                      'Device Information',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Device name: ${widget.device.name}',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text('SSID: $ssid', style: TextStyle(color: Colors.white)),
                  Text('Password: $password',
                      style: TextStyle(color: Colors.white)),
                  Text('Status: $status',
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _toggleSettings,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              255, 106, 97, 19), // background color
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.settings, size: 24, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              "Change characteristics",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (_showSettings) ...[
                    SizedBox(height: 10),
                    TextField(
                      controller: ssidController,
                      style: TextStyle(backgroundColor: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'New SSID',
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      style: TextStyle(backgroundColor: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: _writeUserDetails,
                        child: Text('Save'),
                      ),
                    ),
                  ],
                  SizedBox(height: 25),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.bluetoothController
                            .disconnectDevice(widget.device);
                      },
                      child: Text(
                        "Disconnect",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:ble_Scanner/controllers/bluetooth_controller.dart';
import 'package:ble_Scanner/screens/firstpg.dart';
import 'package:ble_Scanner/models/common_data_response.dart';
import 'package:ble_Scanner/models/common_response.dart';
import 'package:ble_Scanner/utils/utils.dart';

class DeviceHomePage extends StatefulWidget {
  final BluetoothDevice device;
  final BluetoothController bluetoothController =
      BluetoothController(); // Instantiate BluetoothController

  DeviceHomePage({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  _DeviceHomePageState createState() => _DeviceHomePageState();
}

class _DeviceHomePageState extends State<DeviceHomePage> {
  String ssid = '';
  String password = '';
  String status = ''; // Default status
  //String status = '';

  final TextEditingController ssidController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _showSettings =
      false; // Control the visibility of SSID and password input fields
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _listenToConnectionState(); //new
    _readUserDetails();
  }

  @override
  void dispose() {
    ssidController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _readUserDetails() async {
    BluetoothController bluetoothController = Get.find();
    CommonDataResponse commonDataResponse =
        await bluetoothController.readUserDetails(widget.device);

    if (mounted) {
      if (commonDataResponse.state == "S100") {
        String data = commonDataResponse.data;
        List<String> dataList = data.split(':');
        setState(() {
          ssid = dataList[0];
          password = dataList[1];
        });
      } else {
        print(commonDataResponse.stateDescription);
      }
    }
  }

  Future<void> _writeUserDetails() async {
    String newssid = ssidController.text;
    String newPassword = passwordController.text;
    String combinedData = '$newssid:$newPassword';

    print(combinedData);
    print(Utils.convertStringToByte(combinedData));

    BluetoothController bluetoothController = Get.find();
    CommonResponse commonResponse =
        await bluetoothController.writeUserDetails(widget.device, combinedData);

    if (mounted) {
      if (commonResponse.state == 'S100') {
        print("Write success");
        _readUserDetails();
        _showSuccessSnackbar(context);
        //ssidController.clear();
        //passwordController.clear();
      } else {
        print('write failed:${commonResponse.stateDescription}');
      }
    }
  }

  void _listenToConnectionState() {
    widget.bluetoothController
        .getConnectionStateStream(widget.device)
        .listen((BluetoothConnectionState state) {
      setState(() {
        status = state == BluetoothConnectionState.connected
            ? 'Connected'
            : 'Disconnected';
      });
    });
  }

  void _showSuccessSnackbar(BuildContext context) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changes saved successfully.'),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 400),
        ),
      );
    }
  }

  void _showErrorSnackbar(BuildContext context, String errorMessage) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changes failed to save.: $errorMessage'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _toggleSettings() {
    setState(() {
      _showSettings = !_showSettings;
      if (!_showSettings) {
        ssidController.clear();
        passwordController.clear();
      }
      //ssidController.clear();
      // /passwordController.clear();
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/secondpg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      'Device Information',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Device name: ${widget.device.name}',
                            style: TextStyle(fontSize: 16),
                          ),
                          //SizedBox(height: 8),
                          Text(
                            'SSID: $ssid',
                            style: TextStyle(fontSize: 16),
                          ),
                          //SizedBox(height: 8),
                          Text(
                            'Password: $password',
                            style: TextStyle(fontSize: 16),
                          ),
                          //SizedBox(height: 8),
                          Text(
                            'Status: $status',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Center(
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       widget.bluetoothController
                  //           .disconnectDevice(widget.device);
                  //     },
                  //     child: Text(
                  //       "Disconnect",
                  //       style: TextStyle(fontSize: 25),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _toggleSettings,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 106, 97, 19), // background color
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.settings, size: 24, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Change characteristics",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  if (_showSettings) ...[
                    SizedBox(height: 10),
                    TextField(
                      controller: ssidController,
                      style: TextStyle(backgroundColor: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'New SSID',
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      style: TextStyle(backgroundColor: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: _writeUserDetails,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              255, 106, 97, 19), // background color
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 5),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.bluetoothController
                            .disconnectDevice(widget.device);
                      },
                      child: Text(
                        "Disconnect",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
