import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Multiimage extends StatefulWidget {
  const Multiimage({super.key});

  @override
  State<Multiimage> createState() => _MultiimageState();
}

class _MultiimageState extends State<Multiimage> {
  ImagePicker picker = ImagePicker();
  List<XFile> imagelist = [];
  List<Map<String, dynamic>> geturl = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                final List<XFile> select = await picker.pickMultiImage();
                if (select.isNotEmpty) {
                  imagelist.addAll(select);
                }
                setState(() {});
              },
              child: const Text('Select image')),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: imagelist.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Image.file(
                      File(imagelist[index].path),
                      fit: BoxFit.cover,
                    );
                  }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          for (int i = 0; i < imagelist.length; i++) {
            Reference ref = FirebaseStorage.instance.ref(imagelist[i].path);
            await ref.putFile(File(imagelist[i].path));
            var downurl = await ref.getDownloadURL();
            FirebaseFirestore.instance
                .collection('images')
                .doc()
                .set({'image': downurl});
            // geturl.add(downurl);
          }
          print(geturl);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
