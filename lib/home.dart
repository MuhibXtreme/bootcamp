import 'package:flutter/material.dart';
import 'package:from_ui/main.dart';
import 'package:from_ui/second_screen.dart';

class Home extends StatefulWidget {
  final String name;
  const Home({super.key, required this.name});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data = ['Muhib', 'Aizaz', 'Usama', 'bilal'];

  List<Map<String, dynamic>> datalist = [
    {
      'name': 'Muhib',
      'Designation': 'Flutter Devleoper',
      'image':
          'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1600',
    },
    {
      'name': 'junaid',
      'Designation': 'web Devleoper',
      'image':
          'https://images.pexels.com/photos/1040881/pexels-photo-1040881.jpeg?auto=compress&cs=tinysrgb&w=1600',
    },
    {
      'name': 'abdullah',
      'Designation': 'dotnet Devleoper',
      'image':
          'https://images.pexels.com/photos/697509/pexels-photo-697509.jpeg?auto=compress&cs=tinysrgb&w=1600',
    },
    {
      'name': 'mahonoor',
      'Designation': 'worrdpress Devleoper',
      'image':
          'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1600',
    },
    {
      'name': 'zubair',
      'Designation': 'Project manager',
      'image':
          'https://images.pexels.com/photos/1499327/pexels-photo-1499327.jpeg?auto=compress&cs=tinysrgb&w=1600',
    },
    {
      'name': 'abc',
      'Designation': 'abcdef',
      'image':
          'https://images.pexels.com/photos/1080213/pexels-photo-1080213.jpeg?auto=compress&cs=tinysrgb&w=1600',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.name),
        //   centerTitle: true,
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           Navigator.pushAndRemoveUntil(
        //               context,
        //               MaterialPageRoute(builder: (context) => MyApp()),
        //               (route) => false);
        //         },
        //         icon: const Icon(Icons.logout))
        //   ],
        // ),
        body: ListView.builder(
            itemCount: datalist.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(datalist[index]['image']),
                ),
                title: Text(datalist[index]['name']),
                trailing: const Icon(Icons.abc),
                subtitle: Text(datalist[index]['Designation']),
              );
            }));
  }
}
