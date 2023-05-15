import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:from_ui/firstscreen.dart';

class CodeVerify extends StatefulWidget {
  final String verificationcode;
  const CodeVerify({required this.verificationcode, super.key});

  @override
  State<CodeVerify> createState() => _CodeVerifyState();
}

class _CodeVerifyState extends State<CodeVerify> {
  TextEditingController codever = TextEditingController();
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
            TextField(
              controller: codever,
              decoration: const InputDecoration(hintText: 'Enter 6 digit code'),
            ),
            const SizedBox(
              height: 20,
            ),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });

                      final credential = PhoneAuthProvider.credential(
                          verificationId: widget.verificationcode,
                          smsCode: codever.text.toString());
                      try {
                        await FirebaseAuth.instance
                            .signInWithCredential(credential);
                        setState(() {
                          loading = false;
                        });
                        if (context.mounted) {}
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FirstScreen()));
                      } catch (error) {
                        print(error);
                      }
                    },
                    child: const Text('verify'))
          ],
        ),
      ),
    );
  }
}
