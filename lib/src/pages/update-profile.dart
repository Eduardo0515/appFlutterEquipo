import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:appequipo/src/models/UserProfile.dart';

class UpdateProfile extends StatefulWidget {
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _cntrlrFName = TextEditingController();
  final TextEditingController _cntrlrLName = TextEditingController();
  final TextEditingController _cntrlrPhoto = TextEditingController();
  final TextEditingController _cntrlrAddress = TextEditingController();
  final TextEditingController _cntrlrAge = TextEditingController();

  Future<UserProfile> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = fetchUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('UpdateProfile'),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<UserProfile>(
            future: _futureUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 45),
                        color: Color.fromRGBO(249, 246, 239, 1.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80.0,
                            ),
                            _userTextField(snapshot.data.firstName, "Nombre",
                                _cntrlrFName),
                            SizedBox(
                              height: 50.0,
                            ),
                            _userTextField(snapshot.data.lastName, 'Apellido',
                                _cntrlrLName),
                            SizedBox(
                              height: 50.0,
                            ),
                            _userTextField(snapshot.data.address, 'Dirección',
                                _cntrlrAddress),
                            SizedBox(
                              height: 50.0,
                            ),
                            _userNumberField(snapshot.data.age, 'Edad'),
                            SizedBox(
                              height: 50,
                            ),
                            _btnUpdate()
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
              }

              return CircularProgressIndicator();
            },
          ),
        ));
  }

  _userTextField(label, hint, controller) {
    return Container(
        child: Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(label, style: TextStyle(fontSize: 17.0),),
      ),
      TextField(
        keyboardType: TextInputType.name,
        controller: controller,
        decoration: InputDecoration(labelText: hint, counterText: ""),
        maxLength: 100,
      ),
    ]));
  }

  _userNumberField(label, hint) {
    return Container(
        child: Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(label.toString()),
      ),
      TextField(
        keyboardType: TextInputType.number,
        controller: _cntrlrAge,
        decoration:
            InputDecoration(labelText: hint, hintText: label.toString()),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    ]));
  }

  _btnUpdate() {
    return ElevatedButton(
      child: Text('Actualizar información'),
      onPressed: () {
        setState(() {
          _futureUser = updateUserProfile(_cntrlrFName.text, _cntrlrLName.text,
              _cntrlrAddress.text, int.parse(_cntrlrAge.text));
        });
      },
    );
  }
} 

Future<UserProfile> updateUserProfile(
    String fName, String lName, String address, int age) async {
  final http.Response response = await http.put(
    'http://192.168.0.105:3000/users/1',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'firstName': fName,
      'lastName': lName,
      'address': address,
      'age': age
    }),
  );

  if (response.statusCode == 200) {
    return UserProfile.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update user.');
  }
}

Future<UserProfile> fetchUser() async {
  final response = await http.get('http://192.168.0.105:3000/users/1');

  if (response.statusCode == 200) {
    return UserProfile.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}
