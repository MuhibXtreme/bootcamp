import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:from_ui/sign.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController phone = TextEditingController();

  FirebaseStorage firestorage = FirebaseStorage.instance;

  File? imagefile;
  String? downloadimage;

  String imageurl =
      'https://png.pngtree.com/png-vector/20220709/ourmid/pngtree-businessman-user-avatar-wearing-suit-with-red-tie-png-image_5809521.png';

  void add() {
    FirebaseFirestore.instance.collection('users').doc(email.text).set({
      'name': name.text,
      'email': email.text,
      'designation': designation.text,
      'phone': phone.text,
      'image': downloadimage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('email');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Sigin()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading');
            }
            if (snapshot.data!.size == 0) {
              return const Text('no data found');
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data!.docs[index]['image']),
                      ),
                      title: Text(snapshot.data!.docs[index]['name']),
                      subtitle: Text(snapshot.data!.docs[index]['designation']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(snapshot.data!.docs[index]['email'])
                                    .get()
                                    .then((value) {
                                  name.text = value['name'];
                                  designation.text = value['designation'];
                                  email.text = value['email'];
                                  phone.text = value['phone'];
                                });
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: SizedBox(
                                          height: 200,
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller: name,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: "name"),
                                              ),
                                              TextField(
                                                controller: email,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: "email"),
                                              ),
                                              TextField(
                                                controller: designation,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "Designation"),
                                              ),
                                              TextField(
                                                controller: phone,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: "phone no"),
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            color: Colors.red,
                                            textColor: Colors.white,
                                            child: const Text('cancel'),
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              add();
                                              name.clear();
                                              email.clear();
                                              designation.clear();
                                              phone.clear();
                                              Navigator.pop(context);
                                            },
                                            color: Colors.green,
                                            textColor: Colors.white,
                                            child: const Text('Submit'),
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(snapshot.data!.docs[index]['email'])
                                    .delete();
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ));
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: ((context, setState) {
                  return AlertDialog(
                    content: SizedBox(
                      height: 350,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              imagefile == null
                                  ? CircleAvatar(
                                      radius: 65,
                                      backgroundImage: NetworkImage(imageurl),
                                    )
                                  : CircleAvatar(
                                      radius: 65,
                                      backgroundImage: FileImage(imagefile!),
                                    ),
                              Positioned(
                                  bottom: 5,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () async {
                                      ImagePicker picker = ImagePicker();
                                      final image = await picker.pickImage(
                                          source: ImageSource.gallery);
                                      imagefile = File(image!.path);
                                      final String fileName = image.path;
                                      setState(() {});
                                      if (imagefile != null) {
                                        Reference ref =
                                            firestorage.ref(fileName);
                                        await ref.putFile(imagefile!);

                                        downloadimage =
                                            await ref.getDownloadURL();
                                      }
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                      child: const Icon(Icons.add),
                                    ),
                                  ))
                            ],
                          ),
                          TextField(
                            controller: name,
                            decoration: const InputDecoration(hintText: "name"),
                          ),
                          TextField(
                            controller: email,
                            decoration:
                                const InputDecoration(hintText: "email"),
                          ),
                          TextField(
                            controller: designation,
                            decoration:
                                const InputDecoration(hintText: "Designation"),
                          ),
                          TextField(
                            controller: phone,
                            decoration:
                                const InputDecoration(hintText: "phone no"),
                          )
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: const Text('cancel'),
                      ),
                      MaterialButton(
                        onPressed: () {
                          add();
                          name.clear();
                          email.clear();
                          designation.clear();
                          phone.clear();
                          Navigator.pop(context);
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        child: const Text('Submit'),
                      )
                    ],
                  );
                }));
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
