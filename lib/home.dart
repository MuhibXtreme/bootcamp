import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:from_ui/model.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final String name;
  const Home({super.key, required this.name});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController phone = TextEditingController();
  List<Record> employee = [];

  void delete(int id) async {
    var response = await http.delete(Uri.parse(
        "https://6d47-2400-adcc-135-1500-25c9-f5e9-7aa4-3c74.ngrok-free.app/api/public/api/employ/$id"));
    if (response.statusCode == 200) {
      setState(() {});
    }
  }

  Future<List> getdata() async {
    var response = await http.get(Uri.parse(
        'https://6d47-2400-adcc-135-1500-25c9-f5e9-7aa4-3c74.ngrok-free.app/api/public/api/employ'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      employee = (data as List).map((e) => Record.fromJson(e)).toList();
    }
    return employee;
  }

  void add(String name, email, desg, ph) async {
    var response = await http.post(
        Uri.parse(
            'https://6d47-2400-adcc-135-1500-25c9-f5e9-7aa4-3c74.ngrok-free.app/api/public/api/employ'),
        body: {
          "name": name,
          "email": email,
          "designation": desg,
          "phone_no": ph,
        });
    if (response.statusCode == 200) {
      setState(() {});
    }
  }

  void update(int id, String name, email, desg, ph) async {
    var response = await http.post(
        Uri.parse(
            'https://6d47-2400-adcc-135-1500-25c9-f5e9-7aa4-3c74.ngrok-free.app/api/public/api/employ/update'),
        body: {
          "id": "$id",
          "name": name,
          "email": email,
          "designation": desg,
          "phone_no": ph,
        });
    if (response.statusCode == 200) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: employee.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(employee[index].name!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                delete(employee[index].id!);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () {
                                name.text = employee[index].name!;
                                email.text = employee[index].email!;
                                designation.text = employee[index].designation!;
                                phone.text = employee[index].phoneNo!;

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
                                              update(
                                                  employee[index].id!,
                                                  name.text,
                                                  email.text,
                                                  designation.text,
                                                  phone.text);
                                              name.clear();
                                              email.clear();
                                              designation.clear();
                                              phone.clear();
                                              Navigator.pop(context);
                                            },
                                            color: Colors.green,
                                            textColor: Colors.white,
                                            child: const Text('Update'),
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                      subtitle: Text(employee[index].designation!),
                    );
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                          decoration: const InputDecoration(hintText: "name"),
                        ),
                        TextField(
                          controller: email,
                          decoration: const InputDecoration(hintText: "email"),
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
                        add(name.text, email.text, designation.text,
                            phone.text);
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
