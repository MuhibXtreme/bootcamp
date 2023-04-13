import 'package:flutter/material.dart';
import 'package:from_ui/bottom_nav_bar.dart';
import 'package:from_ui/googlemap.dart';
import 'package:from_ui/home.dart';
import 'package:from_ui/second_screen.dart';
import 'package:from_ui/thirdscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const Form(),
      initialRoute: 'form',
      routes: {
        'form': (context) => Home(
              name: '',
            ),
        // 'home': (context) => Home(),
        'second': (context) => SecondScreen(),
      },
    );
  }
}

class Form extends StatelessWidget {
  const Form({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  height: height * 0.2,
                  width: width * 0.2,
                  image: const NetworkImage(
                      'https://images.pexels.com/photos/2235130/pexels-photo-2235130.jpeg?auto=compress&cs=tinysrgb&w=1600')),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Fire Marketing',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Application',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  )
                ],
              )
            ],
          ),
          const Text(
            'Login',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, fontFamily: 'log'),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Enter the Name',
                  prefixIcon: Icon(Icons.person),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Enter Password',
                  prefixIcon: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.lock)),
                  suffixIcon: const Icon(Icons.visibility),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     print('clicked');
          //   },
          //   child: Container(
          //     decoration: BoxDecoration(
          //         color: Colors.red, borderRadius: BorderRadius.circular(15)),
          //     alignment: Alignment.center,
          //     height: 50,
          //     width: 150,
          //     child: const Text('Login'),
          //   ),
          // ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdScreen()
                      // Home(
                      //       name: 'Screen one',
                      //     ),
                      ));
              // Navigator.pushNamed(context, 'home');
            },
            child: const Text('Login'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Dont have an Account?'),
              // Text(
              //   'Signup',
              //   style: TextStyle(color: Colors.red),
              // )
              TextButton(
                  onPressed: () {
                    print('text button clicked');
                  },
                  child: const Text('Signup')),
            ],
          )
        ],
      ),
    );
  }
}
