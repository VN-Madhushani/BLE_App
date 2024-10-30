// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class Homepg extends StatefulWidget {
//   const Homepg({super.key});

//   @override
//   State<Homepg> createState() => _HomepgState();
// }

// class _HomepgState extends State<Homepg> with TickerProviderStateMixin {
//   late final AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0x00962e),
//       body: Center(
//         child: Lottie.asset(
//           "images/checked.json",
//           controller: _controller,
//           onLoaded: (composition) {
//             _controller
//               ..duration = composition.duration
//               ..forward();
//           },
//         ),
//       ),
//     );
//   }
// }
