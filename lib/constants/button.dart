import 'package:ble_Scanner/constants/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback press;
  const Button({super.key, required this.label, required this.press});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.9,
      height: 65,
      decoration: BoxDecoration(
        color: backgroundCOlor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: press,
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
