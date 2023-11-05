// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobileappproject/menu/insert.dart';
import 'package:mobileappproject/menu/insert2.dart';
import 'package:mobileappproject/menu/profile.dart';
import 'package:mobileappproject/menu/home_user.dart';
import 'package:mobileappproject/menu/edit_profile.dart';

class homepage extends StatefulWidget {
  final String email;

  const homepage({Key? key, required this.email}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late String username;
  late List<Widget> tabs;

  int _currentIndex = 0;


  void initState() {
    super.initState();
    username = widget.email;
    tabs = [
      const HomeUser(),
      Profile(username: username),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        iconSize: 25,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color.fromARGB(255, 0, 0, 0)),
          BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts),
              label: 'Profile',
              backgroundColor: Color.fromARGB(255, 0, 0, 0)),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Color(0xFFF5F5F5),
  //     appBar: AppBar(
  //       backgroundColor: Colors.blue,
  //       title: Text("Homepage Flutter"),
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         // ignore: prefer_const_literals_to_create_immutables
  //         children: [
  //           Text(
  //             "Welcome To Flutter",
  //             style: TextStyle(
  //               fontSize: 25,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //           SizedBox(
  //             height: 20,
  //           ),
  //           SizedBox(
  //             width: 350,
  //             height: 60,
  //             child: ElevatedButton(
  //               style: ElevatedButton.styleFrom(
  //                   primary: Color.fromARGB(255, 204, 42, 2),
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(15))),
  //               onPressed: () {
  //                 Navigator.pushNamed(context, 'login');
  //               },
  //               child: Text("Sign out"),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
