import 'package:flutter/material.dart';
import 'package:from_ui/home.dart';
import 'package:from_ui/main.dart';
import 'package:from_ui/second_screen.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Third screen'),
          bottom: const TabBar(
              padding: EdgeInsets.all(10),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.white,
              labelColor: Colors.amber,
              tabs: [
                Text('Home'),
                Text('Abc'),
                Text('Search'),
              ]),
        ),
        body: const TabBarView(children: [
          Home(name: 'hello'),
          SecondScreen(),
          MyApp(),
        ]),
      ),
    );
  }
}
