import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:from_ui/firstscreen.dart';
import 'package:from_ui/forgot_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sigin extends StatefulWidget {
  const Sigin({super.key});

  @override
  State<Sigin> createState() => _SiginState();
}

class _SiginState extends State<Sigin> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool isvisible = false;

  void signin() async {
    SharedPreferences prefdata = await SharedPreferences.getInstance();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      if (context.mounted) {}
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Successfully')));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FirstScreen()));

      prefdata.setString('email', email.text);
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$err')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Email',
                    hintText: 'Enter Email',
                    prefixIcon: Icon(Icons.email),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field cannot be empty";
                  }
                  if (!value.contains('@')) {
                    return "A valid email should contain @";
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: isvisible,
                controller: password,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Password',
                    hintText: 'Enter password',
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (!isvisible) {
                            isvisible = true;
                            setState(() {});
                          } else {
                            isvisible = false;
                            setState(() {});
                          }
                        },
                        icon: isvisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field cannot be empty";
                  }
                  if (value.length < 6) {
                    return "At least 6 character long";
                  }
                },
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                      },
                      child: const Text('Forget Password?'))),
              ElevatedButton(
                  onPressed: () {
                    final isvalid = formkey.currentState!.validate();
                    if (!isvalid) {
                      return;
                    }
                    signin();
                  },
                  child: const Text('Sigin'))
            ],
          ),
        ),
      ),
    );
  }
}
