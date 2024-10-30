// import 'package:flutter/material.dart';
// //import 'package:flutter_svg/flutter_svg.dart';

// class BlueAnime extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Bluetooth Animation',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Bluetooth Icon Animation'),
//         ),
//         body: Center(
//           child: BluetoothIconAnimation(),
//         ),
//       ),
//     );
//   }
// }

// class BluetoothIconAnimation extends StatefulWidget {
//   @override
//   _BluetoothIconAnimationState createState() => _BluetoothIconAnimationState();
// }

// class _BluetoothIconAnimationState extends State<BluetoothIconAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: true);

//     _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _animation.value,
//           child: SvgPicture.asset(
//             'assets/images/blue.jpg',
//             width: 100,
//             height: 100,
//             color: Colors.blueAccent,
//           ),
//         );
//       },
//     );
//   }
// }
