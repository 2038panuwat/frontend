// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobileappproject/login.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  @override
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future sign_up() async{
    String url = "http://192.168.1.60/flutter_project/register.php";
    final response = await http.post(Uri.parse(url), body:{
        'name':name.text,
        'email':email.text,
        'password':pass.text,
    });
    var data = json.decode(response.body);
    if(data=="Error"){
      Navigator.pushNamed(context, 'login');
    }else{
      Navigator.pushNamed(context, 'home');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Please complete your',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Text(
                    'biodata correctly',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Your name',
                      ),
                      validator: (val){
                        if(val!.isEmpty){
                          return 'Empty';
                        }
                        return null;
                      },
                      controller: name,//เก็บค่าข้อมูลที่กรอก
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Your E-Mail',
                      ),
                      validator: (val){
                        if(val!.isEmpty){
                          return 'Empty';
                        }
                        return null;
                      },
                      controller: email,//เก็บค่าข้อมูลที่กรอก
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Create your Password',
                      ),
                      validator: (val){
                        if(val!.isEmpty){
                          return 'Empty';
                        }
                        return null;
                      },
                      controller: pass,//เก็บค่าข้อมูลที่กรอก
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Re-Type your Password',
                      ),
                      validator: (val){
                        if(val!.isEmpty){
                          return 'Empty';
                        }else if(val != pass.text){
                          return 'password not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 204, 42, 2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                        // Navigator.pushNamed(context, 'home');
                        bool pass = formKey.currentState!.validate();

                        if(pass){
                          sign_up();
                        }
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 20,
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
