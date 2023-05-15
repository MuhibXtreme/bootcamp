import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:from_ui/code_verify.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  TextEditingController phoneno = TextEditingController();
  String code = '+92';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('phone authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 55,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('+92'),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: 1,
                    color: Colors.grey,
                  ),
                  Expanded(
                      child: TextField(
                    controller: phoneno,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Phone no"),
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });
                      FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: code + phoneno.text,
                          verificationCompleted: (message) {
                            setState(() {
                              loading = false;
                            });
                          },
                          verificationFailed: (message) {},
                          codeSent: (String verificationId, int? token) {
                            setState(() {
                              loading = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CodeVerify(
                                          verificationcode: verificationId,
                                        )));
                          },
                          codeAutoRetrievalTimeout: (message) {});
                    },
                    child: const Text('Login'))
          ],
        ),
      ),
    );
  }
}
