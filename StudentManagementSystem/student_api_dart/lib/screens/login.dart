import 'dart:html';

import 'package:student_api_dart/http/httpuser.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();

  String uname = '';
  String psw = '';

  //lets create a future and call httpuser.dart loginUser so that we could run that here and store the output in here
  Future<bool> loginUsers(String uname, String psw) {
    var res = HttpConnectUser().loginPost(uname, psw);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Form(
              key: formkey,
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Welcome To Login Page',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        color: Colors.black87,
                      ),
                    ),
                    const Image(
                      image: NetworkImage(
                        'https://img.search.brave.com/J35AaskD84R60svnaC5KCswNCA9cD7sR0idz6AWYOyc/rs:fit:980:980:1/g:ce/aHR0cHM6Ly9pY29u/LWxpYnJhcnkuY29t/L2ltYWdlcy9pY29u/LWxvZ2luL2ljb24t/bG9naW4tNC5qcGc',
                      ),
                      height: 150,
                      width: 130,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onSaved: (newValue) {
                        uname = newValue!;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (newValue) {
                        psw = newValue!;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        //this will save the current value availble in the forms

                        formkey.currentState!.save();

                        var res = await loginUsers(uname, psw);
                        if (res) {
                          Navigator.pushNamed(context, '/add_student');
                          MotionToast.success(
                            description: Text('Login Successfull!'),
                          ).show(context);
                        } else {
                          MotionToast.error(
                            description: Text('Invalid Credentials'),
                          ).show(context);
                        }
                      },
                      child: Text('L O G I N'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    return scaffold;
  }
}
