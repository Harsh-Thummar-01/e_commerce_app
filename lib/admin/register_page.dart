// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, noop_primitive_operations, inference_failure_on_instance_creation

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/user_model.dart';
import 'package:e_commerce_app/admin/login_page.dart';
import 'package:e_commerce_app/admin/profile.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final emailcontrol = TextEditingController();
  final passwordcontrol = TextEditingController();
  final usercontrol = TextEditingController();


  Future<void> register() async {
    final userName = usercontrol.text.trim();
    final email = emailcontrol.text.trim();
    final password = passwordcontrol.text.trim();

    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      
      
    } on FirebaseAuthException catch(e){
      log(e.code.toString());
    }

    if (credential != null) {
      final uid = credential.user!.uid;
      final newUser = UserModel(
        uid: uid,
        email: email,
        userName: userName,
        firstName: '',
        lastName: '',
        comment: '',
        imageUrl: '',
      );
      await FirebaseFirestore.instance.collection('users').doc(uid).set(newUser.toMap()).then((value) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Profile(userModel: newUser, firebaseUser: credential!.user!); 
      },),),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Padding(
                  padding: EdgeInsets.only(top: 80, bottom: 20),
                  child: Text(
                    'Register Page',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: textColor,),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5,),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: usercontrol,
                          cursorColor: textColor,
                          decoration: InputDecoration(
                              fillColor: color,
                              filled: true,
                              prefixIcon:const Icon(Icons.person,
                                  color: textColor,),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:const BorderSide(
                                    width: 1.5,
                                    color: textColor,),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    width: 1.5,
                                    color: textColor,),
                              ),
                              hintText: 'User name',),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5,),
                        child: TextFormField(
                          controller: emailcontrol,
                          cursorColor: textColor,
                          decoration: InputDecoration(
                              fillColor: color,
                              filled: true,
                              prefixIcon: const Icon(Icons.email,
                                  color: textColor,),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: textColor,),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: textColor,),
                              ),
                              hintText: 'E-mail-Id',),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5,),
                        child: TextFormField(
                          controller: passwordcontrol,
                          cursorColor: textColor,
                          decoration: InputDecoration(
                              fillColor: color,
                              filled: true,
                              prefixIcon: Icon(Icons.password,
                                  color: textColor,),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: textColor,),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: textColor,),
                              ),
                              hintText: 'Password',),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 4,
                              backgroundColor: textColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),),),
                          onPressed: register,
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('already have an account?'),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),);
                            },
                            child: Text(
                              'Login',
                              style:
                              TextStyle(color: textColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 
}
