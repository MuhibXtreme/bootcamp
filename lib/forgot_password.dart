import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:from_ui/sign.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailcont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Forgot password',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: emailcont,
                decoration: const InputDecoration(
                  hintText: 'Enter email',
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailcont.text)
                        .then((value) => {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Password reset link has been sent to the specified url'))),
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Sigin())),
                            })
                        .catchError((error) => {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error.toString()))),
                            });
                  },
                  child: const Text('Get New Password'))
            ],
          ),
        ),
      ),
    );
  }
}
