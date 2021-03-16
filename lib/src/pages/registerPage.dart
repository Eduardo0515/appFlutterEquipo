import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String user = "";
  String pass = "";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromRGBO(240, 94, 100, 1.0),
        centerTitle: true,
        title: Text('Registro'),
      ),
      body: Container(
        color: Color.fromRGBO(249, 246, 239, 1.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 300.0,
              ),
              _userTextField(),
              SizedBox(
                height: 15.0,
              ),
              _userPassword(),
              SizedBox(
                height: 25,
              ),
              _bottonLogin()
            ],
          ),
        ),
      ),
    );
  }

  _userTextField() {
    return Container(
      child: FadeInDown(
        duration: Duration(milliseconds: 250),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'Example@gmail.com',
              labelText: 'Correo Electronico'),
          onChanged: (String str) {
            user = str;
          },
          onSubmitted: (String str) {
            user = str;
          },
        ),
      ),
    );
  }

  _userPassword() {
    return Container(
      child: FadeInDown(
        duration: Duration(milliseconds: 250),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
              icon: Icon(Icons.vpn_key),
              hintText: 'Contraseña',
              labelText: 'Contraseña'),
          onChanged: (String str) {
            pass = str;
          },
          onSubmitted: (String str) {
            pass = str;
          },
        ),
      ),
    );
  }

  _bottonLogin() {
    return FadeInLeft(
      child: ElevatedButton(

          // child: Container(
          //   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          //   child: Text('Iniciar sesión'),
          // ),
          // elevation: 10,
          // color: Color.fromRGBO(42, 200, 194, 10),
          // onPressed: () {
          //   if (user != "" && pass != "") {
          //     Fluttertoast.showToast(
          //         msg: 'Login success \n  Welcome $user',
          //         toastLength: Toast.LENGTH_SHORT,
          //         gravity: ToastGravity.BOTTOM,
          //         timeInSecForIosWeb: 1,
          //         backgroundColor: Colors.grey,
          //         textColor: Colors.white,
          //         fontSize: 16.0);
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => NombresPage()));
          //   } else {
          //     Fluttertoast.showToast(
          //         msg: 'Login failed \n  Please insert a valid user and password',
          //         toastLength: Toast.LENGTH_SHORT,
          //         gravity: ToastGravity.BOTTOM,
          //         timeInSecForIosWeb: 1,
          //         backgroundColor: Colors.grey,
          //         textColor: Colors.white,
          //         fontSize: 16.0);
          //   }
          // },
          ),
    );
  }
}
