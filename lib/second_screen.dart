import 'package:flutter/material.dart';
import 'package:from_ui/thirdscreen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Second Screen'),
      // ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ThirdScreen()));
            },
            child: const Text('Navigate to third')),
      ),
    );
  }
}
