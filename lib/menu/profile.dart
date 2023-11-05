import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobileappproject/home.dart';
import 'package:mobileappproject/login.dart';
import 'package:mobileappproject/menu/edit_profile.dart';
import 'package:mobileappproject/menu/home_user.dart';
import 'package:mobileappproject/menu/insert.dart';
import 'package:mobileappproject/menu/insert2.dart';
import 'package:mobileappproject/menu/personal.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  final String username;

  const Profile({Key? key, required this.username}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Map<String, dynamic>> userData = [];

  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.home_outlined),
          onPressed: (){},
        ),
        title: const Text('Profile'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Expanded(child: editprofile()),
          ],
        ),
      ),
    );
  }

  Widget editprofile() {
    return ListView.builder(
      itemCount: userData.length,
      itemBuilder: (context, index) {
        final user = userData[index];
        return InkWell(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 180,
                  height: 180,
                  child: ClipRRect(child: Image.asset('pf.png')),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Name: ${user['name']}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 10,
                ),
                Text('Email: ${user['email']}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 204, 42, 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfile(user)),
                      );
                      // fetchData();
                    },
                    child: const Text(
                      'edit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 204, 42, 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Insert(user)),
                      );
                    },
                    child: const Text(
                      'Revenue',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 204, 42, 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Insert2(user)),
                      );
                    },
                    child: const Text(
                      'Expenses',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 204, 42, 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Personal(user)),
                      );
                    },
                    child: const Text(
                      'Personal',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 204, 42, 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => login()),
                      );
                    },
                    child: const Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Future<void> fetchData() async {
    String url = "http://192.168.1.60/flutter_project/user_get.php";
    final response = await http.post(Uri.parse(url), body: {
      'username': widget.username,
    });
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List;
      userData = List<Map<String, dynamic>>.from(jsonData);
    } else {
      print('Error: ${response.statusCode}');
    }
  }
}