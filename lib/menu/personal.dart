import 'package:flutter/material.dart';
import 'package:mobileappproject/home.dart';
import 'package:mobileappproject/menu/profile.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mobileappproject/home.dart';
import 'dart:convert';

class Personal extends StatefulWidget {
  final Map<String, dynamic> editdata;

  const Personal(this.editdata, {super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  List<Map<String, dynamic>> editdata = [];

  final formKey = GlobalKey<FormState>();

  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();

  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String url = "http://192.168.1.60/flutter_project/personal.php";
    final response = await http.post(Uri.parse(url), body: {
      'id': widget.editdata['id'],
      'address': address.text,
      'phone': phone.text,
    });
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List;
      setState(() {
        editdata = List<Map<String, dynamic>>.from(jsonData);
      });
    } else {
      print('Error:${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Personal'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Please fill in the information',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'address',
                      ),
                      controller: address,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'phone',
                      ),
                      controller: phone,
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
                        primary: const Color.fromARGB(255, 204, 42, 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () {
                        // Navigator.pushNamed(context, 'home');
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => homepage(
                        //           email: '',
                        //         )));
                        if (formKey.currentState!.validate()) {
                          fetchData();
                        }
                      },
                      child: const Text(
                        'Enter',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
