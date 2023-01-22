// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, cast_nullable_to_non_nullable, inference_failure_on_instance_creation, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/user_model.dart';
import 'package:e_commerce_app/admin/register_page.dart';
import 'package:e_commerce_app/home_page.dart';
import 'package:e_commerce_app/local_storage/sharedprefs.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();

   login() async {
    String email = emailControl.text.trim();
    String password = passwordControl.text.trim();

    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      stdout.write(e.message.toString());
    }

    if (credential != null) {
      final user = credential.user;
      final uid = user!.uid;

      final DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final userModel =
          UserModel.fromMap(userData.data() as Map<String, dynamic>);
      setState(() {
        sharedPrefs.uid = userModel.uid.toString();
        sharedPrefs.email = userModel.email.toString();
        sharedPrefs.userName = userModel.userName.toString();
        sharedPrefs.firstName = userModel.firstName.toString();
        sharedPrefs.lastName = userModel.lastName.toString();
        sharedPrefs.comment = userModel.comment.toString();
        sharedPrefs.imageUrl = userModel.imageUrl.toString();
      });
       Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomePage(),
          ));

      stdout.write('Log In Siccessfully');
    }
    else{
      stdout.write("Log in failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100, bottom: 20),
                child: Text(
                  'Login Page',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: TextFormField(
                        controller: emailControl,
                        cursorColor: textColor,
                        decoration: InputDecoration(
                          fillColor: color,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.email,
                            color: textColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 1.5,
                              color: textColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 1.5,
                              color: textColor,
                            ),
                          ),
                          hintText: 'E-mail-Id',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordControl,
                        cursorColor: textColor,
                        decoration: InputDecoration(
                          fillColor: color,
                          filled: true,
                          prefixIcon:const Icon(
                            Icons.password,
                            color: textColor,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 1.5,
                              color: textColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 1.5,
                              color: textColor,
                            ),
                          ),
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  backgroundColor: textColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),
                onPressed: (){
                  login();
                  log('--------------------------- ${sharedPrefs.firstName} ----------------------------------');
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color:textColor),
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

// InkWell(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => const MobileScreen(),
// ));
// },
// child: Container(
// height: 50,
// margin: const EdgeInsets.all(20),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(25),
// color: Colors.redAccent.shade100,
// ),
// child: Row(
// // ignore: prefer_const_literals_to_create_immutables
// children: [
// const Padding(
// padding: EdgeInsets.only(left: 3.5),
// child: CircleAvatar(
// backgroundColor: Colors.white,
// radius: 22,
// child: Icon(
// Icons.phone,
// color: Colors.redAccent,
// ),
// ),
// ),
// const SizedBox(
// width: 10,
// ),
// const Text(
// "Create with Mobile Number",
// style: TextStyle(
// fontSize: 15,
// color: Colors.white,
// fontWeight: FontWeight.bold),
// ),
// const SizedBox(
// width: 10,
// ),
// const Icon(
// Icons.navigate_next,
// color: Colors.white,
// ),
// ],
// ),
// ),
// )
