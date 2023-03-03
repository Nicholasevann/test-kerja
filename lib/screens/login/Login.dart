import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:test_kerja/screens/home/Home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  final email = TextEditingController();
  final password = TextEditingController();

  void doLogin() {
    if (email.text == 'fluttertest@swamedia.com' &&
        password.text == 'fluttertest') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home(
                  email: email.text,
                )),
      );
    } else {
      Get.snackbar('Gagal',
          'Silahkan masukkan username dan password kembali dengan benar');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email :'),
                  TextField(
                    controller: email,
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Password :'),
                  TextField(
                    controller: password,
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  doLogin();
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.blue,
                  width: double.infinity,
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
