import 'dart:convert';

import 'package:appequipo/src/models/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatelessWidget {
  final String userid;

  Dashboard({Key key, @required this.userid}) : super(key: key);

  Future<User> getuser(String userid) async {
    final response = await http.get("https://reqres.in/api/users/${userid}");
    if (response.statusCode == 200) {
      print("EXITO");
      print(json.decode(response.body)['data']);
      return User.fromJson(json.decode(response.body)['data']);
    } else {
      print("hubo un error");
      throw Exception("ERROR");
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<User> user = getuser(this.userid.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.blue,
            ),
            onPressed: () {
              // Navigator.pop(context);
            }),
        actions: [
          TextButton(
            onPressed: () {
              //ir a editar
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "EDITAR",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            style: ButtonStyle(),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "${snapshot.data.avatar}", //imagen del avatar
                            ))),
                  ),
                ),
                Text(
                  "${snapshot.data.name}  ${snapshot.data.lastname}",
                  style: TextStyle(fontSize: 20, height: 5),
                ),
                Text(
                  "Edad: ${snapshot.data.id} ",
                  style: TextStyle(fontSize: 20, height: 3),
                ),
                Text(
                  "Dirección:  ${snapshot.data.avatar} ",
                  style: TextStyle(fontSize: 18, height: 2),
                ),
              ]);
            } else {
              return Text("error${snapshot.hasError}");
            }
          },
        ),
      ),
    );
  }
}
