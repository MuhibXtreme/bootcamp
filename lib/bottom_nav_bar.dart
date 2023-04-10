import 'package:flutter/material.dart';
import 'package:from_ui/fourth.dart';
import 'package:from_ui/home.dart';
import 'package:from_ui/second_screen.dart';
import 'package:from_ui/thirdscreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedindex = 0;

  List pages = const [
    Home(
      name: '',
    ),
    SecondScreen(),
    ThirdScreen(),
    FourthScreen(),
  ];

  void changeindex(int indexx) {
    selectedindex = indexx;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom NavBar'),
        centerTitle: true,
      ),
      body: pages[selectedindex],
      bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      changeindex(0);
                    },
                    icon: Icon(
                      Icons.home,
                      color: selectedindex == 0 ? Colors.red : Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      changeindex(1);
                    },
                    icon: Icon(
                      Icons.person,
                      color: selectedindex == 1 ? Colors.red : Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      changeindex(2);
                    },
                    icon: Icon(
                      Icons.settings,
                      color: selectedindex == 2 ? Colors.red : Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      changeindex(3);
                    },
                    icon: Icon(
                      Icons.contact_emergency,
                      color: selectedindex == 3 ? Colors.red : Colors.white,
                    )),
              ],
            ),
          )
          // BottomNavigationBar(
          //     onTap: (index) {
          //       changeindex(index);
          //     },
          //     backgroundColor: Colors.black,
          //     selectedItemColor: Colors.red,
          //     unselectedItemColor: Colors.white,
          //     type: BottomNavigationBarType.fixed,
          //     currentIndex: selectedindex,
          //     items: const [
          //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          //       BottomNavigationBarItem(icon: Icon(Icons.person), label: 'About'),
          //       BottomNavigationBarItem(
          //           icon: Icon(Icons.settings), label: 'setting'),
          //       BottomNavigationBarItem(
          //           icon: Icon(Icons.contact_emergency), label: 'contact')
          //     ]),
          ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {},
        child: const Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
