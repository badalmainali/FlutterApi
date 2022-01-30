import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:student_api_dart/http/httpuser.dart';

import 'package:student_api_dart/models/user.dart';
import 'package:motion_toast/motion_toast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final reg_form = GlobalKey<FormState>();
  String fname = '';
  String lname = '';
  String username = '';
  String password = '';

  Future<bool> registerUser(User u) {
    var res = HttpConnectUser().registerPost(u);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Register Page')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SafeArea(
            child: Form(
              key: reg_form,
              child: Column(
                children: [
                  const Image(
                    image: NetworkImage(
                      'https://img.search.brave.com/iTslug77UW4V7XWukWz3l6DzvfTgJ_88NKB-mugwT7E/fit/498/498/ce/1/aHR0cHM6Ly93d3cu/bGlrZTRsaWtlLm9y/Zy9pbWcvbG9naW4v/cmVnaXN0ZXIucG5n',
                    ),
                    height: 110,
                    width: 90,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      fname = value!;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Enter First Name',
                        labelText: 'Fname',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      lname = value!;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Enter Last Name',
                        labelText: 'Lname',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      username = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter username',
                      labelText: 'Uname',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      password = value!;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Enter Password',
                        labelText: 'Password',
                        focusColor: Colors.red,
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (reg_form.currentState!.validate()) {
                        reg_form.currentState!.save();

                        User u = User(
                            firstname: fname,
                            lastname: lname,
                            username: username,
                            password: password);
                        bool isCreated = await registerUser(u);
                        if (isCreated) {
                          Navigator.pushNamed(context, '/login');
                          MotionToast.success(
                                  description: const Text('New user Created'))
                              .show(context);
                        } else {
                          MotionToast.error(
                                  description:
                                      const Text('Something went wrong'))
                              .show(context);
                        }
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 55),
                      elevation: 12,
                      shadowColor: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 63),
                    child: Row(
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('LOGIN'),
                          style: TextButton.styleFrom(
                              elevation: 25,
                              shadowColor: Colors.grey,
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
