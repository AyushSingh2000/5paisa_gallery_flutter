import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/blocs/image_bloc.dart';
import '../../view_model/repo/img_repository.dart';
import 'image_grid_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        animate = true;
      });
    });
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => ImageBloc(repository: ImageRepository()),
            child: ImageGridScreen(),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
              curve: Curves.easeInOut,
              top: animate ? width : -100,
              left: animate ? width - 140 : -50,
              duration: const Duration(milliseconds: 2500),
              child: const CircleAvatar(
                backgroundColor: Color(0xFF1976D2),
                radius: 600,
              )),
          AnimatedPositioned(
              curve: Curves.easeInOut,
              top: animate ? width / 3 : height - 100,
              left: animate ? -100 : width - 50,
              duration: const Duration(milliseconds: 2500),
              child: const CircleAvatar(
                backgroundColor: Color(0xFFD81B60),
                radius: 300,
              )),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 80,
              sigmaY: 80,
            ),
            child: Container(),
          ),
          AnimatedOpacity(
            opacity: animate ? 1 : 0,
            curve: Curves.easeInExpo,
            duration: const Duration(milliseconds: 2000),
            child: SizedBox(
              height: 500,
              width: 500,
              child: Image.asset(
                'assets/aesthetic-background-with-greek-bust.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 160,
            child: RotatedBox(
              quarterTurns: 3, // Rotates 90 degrees clockwise
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1500),
                opacity: animate ? 1 : 0,
                child: Text(
                  'GALLERY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 200,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // AnimatedPositioned(
          //   curve: Curves.easeInOut,
          //   top: animate ? height * 0.85 : height * 0.90,
          //   duration: const Duration(milliseconds: 2500),
          //   child: AnimatedOpacity(
          //     opacity: animate ? 1 : 0,
          //     duration: const Duration(milliseconds: 1500),
          //     child: Text(
          //       'powered by picsum',
          //       style: TextStyle(
          //         fontSize: height * 0.02,
          //         fontWeight: FontWeight.bold,
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
