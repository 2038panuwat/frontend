import 'package:flutter/material.dart';
import 'package:mobileappproject/menu/home_user.dart';
import 'package:mobileappproject/home.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mobileappproject/home.dart';
import 'dart:convert';

class Insert extends StatefulWidget {

  final Map<String, dynamic> editdata;

  const Insert(this.editdata, {super.key});

  @override
  State<Insert> createState() => _InsertState();
}

class _InsertState extends State<Insert> {

  List<Map<String, dynamic>> editdata = [];

  void initState(){
    super.initState();
    fetchData();
  }

    Future<void> fetchData() async{
    String url = "http://192.168.1.60/flutter_project/rairub.php";
    final response = await http.post(Uri.parse(url),body: {
      'id' : widget.editdata['id'],
      'name': name.text,
      'money':money.text,
      'date':date.text,
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
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController money = TextEditingController();
  TextEditingController date = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.black,
        // leading: IconButton(
        //   icon: Icon(Icons.push_pin_outlined),
        //   onPressed: (){},
        // ),
        title: const Text('Revenue'),
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
                    'Today Information',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Please fill in the information',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Item Name',
                        prefixIcon: Icon(Icons.insert_emoticon),
                      ),
                      validator: (val){
                        if(val!.isEmpty){
                          return 'Empty';
                        }
                        return null;
                      },
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
                        labelText: 'Amount of Money',
                        prefixIcon: Icon(Icons.money),
                      ),
                      validator: (val){
                        if(val!.isEmpty){
                          return 'Empty';
                        }
                        return null;
                      },
                      controller: money,
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
                        labelText: 'Processing date',
                        prefixIcon: Icon(Icons.timelapse),
                      ),
                      validator: (val){
                        if(val!.isEmpty){
                          return 'Empty';
                        }
                        return null;
                      },
                      controller: date,
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
                        // // Navigator.pushNamed(context, 'HomeUser');
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> homepage(email: '',)));

                        if(formKey.currentState!.validate()){
                            fetchData();
                          }
                      },
                      child: const Text(
                        'Input',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 12,),
                    ),
                    onPressed: () {
                      //Navigator.pushNamed(context, 'homepage');
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> homepage(email: '',)));
                    }, child: const Text("Cancel filling out information"),
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