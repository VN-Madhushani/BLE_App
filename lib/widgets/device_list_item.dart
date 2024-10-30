import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:ble_Scanner/constants/button.dart';
import 'package:page_transition/page_transition.dart';

class DeviceListItem extends StatelessWidget {
  final ScanResult device;
  final Function(BluetoothDevice) onConnectPressed;
  //final bool isConnected;

  const DeviceListItem({
    Key? key,
    required this.device,
    required this.onConnectPressed,
    //required this.isConnected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceName =
        device.device.name.isNotEmpty ? device.device.name : 'Unknown Device';

    return Card(
      elevation: 2,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),

        title: Text(deviceName),
        // subtitle: Text(device.device.id.id),
        // trailing: Text(device.rssi.toString()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(device.device.id.id),
            Text(device.rssi.toString()),
          ],
        ),

        trailing: SizedBox(
          width: 80,
          child: Button(
            label: 'Connect',
            press: () => onConnectPressed(device.device),
          ),
        ),
      ),
    );
  }
}
