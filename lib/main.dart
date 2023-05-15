import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:from_ui/firstscreen.dart';
import 'package:from_ui/second_screen.dart';
import 'package:from_ui/showimage.dart';
import 'package:from_ui/sign.dart';
import 'package:from_ui/splash.dart';

import 'package:from_ui/thirdscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'code_verify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefdata = await SharedPreferences.getInstance();
  var email = prefdata.getString('email');
  await Firebase.initializeApp();

  runApp(MyApp(
    email: email,
  ));
}

class MyApp extends StatelessWidget {
  final String? email;
  const MyApp({this.email, super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const Form(),
      initialRoute: 'form',
      routes: {
        'form': (context) =>
            email != null ? const FirstScreen() : const SplashScreen(),
        // 'home': (context) => Home(),
        'second': (context) => const SecondScreen(),
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
