import 'dart:async';

import 'package:flutter/material.dart';
import 'package:from_ui/sign.dart';

import 'firstscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startsplashscreen();
  }

  void startsplashscreen() {
    Timer(const Duration(seconds: 5), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FirstScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://img.freepik.com/free-vector/golden-bird-logo-design_1195-336.jpg?w=2000'),
              fit: BoxFit.fill),
        ),
      ),
    );
  }
}
