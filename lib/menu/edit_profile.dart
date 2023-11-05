import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobileappproject/home.dart';
import 'package:http/http.dart' as http;
import 'package:mobileappproject/menu/home_user.dart';
import 'package:mobileappproject/menu/profile.dart';

class EditProfile extends StatefulWidget{

  final Map<String, dynamic> editdata;

  const EditProfile(this.editdata, {super.key});

  State<EditProfile> createState()=>_edit();

}

class _edit extends State<EditProfile>{

  List<Map<String, dynamic>> editdata = [];

  void initState(){
    super.initState();
    fetchData();
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future<void> fetchData() async{
    String url = "http://192.168.1.60/flutter_project/updateuser.php";
    final response = await http.post(Uri.parse(url),body: {
      'id' : widget.editdata['id'],
      'name': name.text,
      'email':email.text,
      'pass':pass.text,
    });
    print(response.body);
    if(response.statusCode == 200){
      final jsonData = json.decode(response.body) as List;
      setState(() {
        editdata = List<Map<String , dynamic>>.from(jsonData);
      });
    } else{
      print('Error:${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Cancle'),
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
                  Icon(Icons.person_3),
                  Text(
                    'Edit Information',
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    'Completely fill in the information',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'you want to edit.',
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
                        labelText: 'Name', 
                        prefixIcon: Icon(Icons.person),
                      ),
                      controller: name,
                    ),
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
                        labelText: 'Email', 
                        prefixIcon: Icon(Icons.email),
                      ),
                      controller: email,
                    ),
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
                        labelText: 'Password', 
                        prefixIcon: Icon(Icons.password),
                      ),
                      controller: pass,
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
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                          //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> homepage(email: '',)));
                          if(formKey.currentState!.validate()){
                            fetchData();
                          }
                      },
                      child: const Text(
                        'Edit Profile',
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
      ),
    );

  }
}