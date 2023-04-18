import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool isvisible = false;

  void signin() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Successfully added')));
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Name',
                    hintText: 'Enter the Name',
                    prefixIcon: Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field cannot be empty";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
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
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
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
            ),
            ElevatedButton(
                onPressed: () {
                  final isvalid = formkey.currentState!.validate();
                  if (!isvalid) {
                    return;
                  }
                  signin();
                },
                child: const Text('Signup'))
          ],
        ),
      ),
    );
  }
}
