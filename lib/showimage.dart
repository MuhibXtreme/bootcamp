import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({super.key});

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('images').snapshots(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snap.data!.docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(20),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                NetworkImage(snap.data!.docs[index]['image']))),
                  );
                });
          }),
    );
  }
}
