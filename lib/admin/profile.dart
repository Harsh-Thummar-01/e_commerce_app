
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Model/user_model.dart';
import 'package:e_commerce_app/home_page.dart';
import 'package:e_commerce_app/local_storage/sharedprefs.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseUser;
  const Profile({super.key,this.userModel,this.firebaseUser});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    super.initState();
    firstcontrol.text = sharedPrefs.firstName ?? '';
    lastcontrol.text = sharedPrefs.lastName ?? '';
    commentcontrol.text = sharedPrefs.comment ?? '';
    // setState(() {
    //   imageFile = imageFile;
    // });


  }
  final formKey = GlobalKey<FormState>();
  final firstcontrol = TextEditingController();
  final lastcontrol = TextEditingController();
  final commentcontrol = TextEditingController();

  File? imageFile;
  
  
  Future selectImage(ImageSource source) async {
   final pickedFile = await ImagePicker().pickImage(source: source);

   if (pickedFile != null) {
     cropImage(pickedFile);
   }

  }

  Future cropImage(XFile file) async {
    final croppedImage = await ImageCropper().cropImage(sourcePath: file.path);

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  Future uploadData() async {
    final uploadTask = FirebaseStorage.instance.ref('profilePicture/').child(sharedPrefs.uid.toString()).putFile(imageFile!);

    final String imageUrl = await uploadTask.snapshot.ref.getDownloadURL();
    final String firstName = firstcontrol.text.trim();
    final String lastName = lastcontrol.text.trim();
    final String comment= commentcontrol.text.trim();
    //
    widget.userModel!.firstName = firstName;
    widget.userModel!.lastName = lastName;
    widget.userModel!.comment = comment;
    widget.userModel!.imageUrl = imageUrl;

    if(widget.userModel!.uid!.isNotEmpty) {
       FirebaseFirestore.instance.collection('users').doc(widget.userModel!.uid).update(widget.userModel!.toMap());

       Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage()
            ,),);
    }
    else
      {
         FirebaseFirestore.instance.collection('users').doc(sharedPrefs.uid).set(widget.userModel!.toMap());

         Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage()
              ,),);
      }


  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userData;

  data(User user) async {
   final getData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
   final getUserData = UserModel.fromMap(getData.data() as Map<String, dynamic>);
   userData = getUserData;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                'Fill The Profile',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: textColor,),
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                   CircleAvatar(
                    radius: 80,
                    backgroundImage:imageFile != null ? FileImage(imageFile!) : null,
                    backgroundColor:color,
                    child: imageFile == null ? const Icon(Icons.person,
                    size: 80,
                    color: textColor):null,
                  ),
                  Positioned(
                    bottom: 10,
                    right: 0,
                    child: InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            title: const Text('Select Image'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        CupertinoButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                            selectImage(ImageSource.gallery);
                                          },
                                          child:const CircleAvatar(
                                            radius: 25,
                                            backgroundColor: color,
                                            child: Icon(Icons.photo,color: textColor,),
                                          ),
                                        ),
                                        const SizedBox(height: 2,),
                                        const Text('Gallery'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        CupertinoButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                            selectImage(ImageSource.camera);
                                          },
                                          child: const CircleAvatar(
                                            radius: 25,
                                            backgroundColor: color,
                                            child: Icon(Icons.camera,color: textColor,),
                                          ),
                                        ),
                                        const SizedBox(height: 2,),
                                        const Text('Camera'),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: textColor,),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7,),
                      child: TextFormField(
                        controller: firstcontrol,
                        decoration: InputDecoration(
                            fillColor: color,
                            filled: true,
                            hintText: 'First Name',
                            hoverColor: Colors.grey.shade300,
                            prefixIcon: Icon(
                              Icons.person,
                              color: textColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: textColor,),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: textColor,),
                              borderRadius: BorderRadius.circular(12),
                            ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7,),
                      child: TextFormField(
                        controller: lastcontrol,
                        decoration: InputDecoration(
                            fillColor: color,
                            filled: true,
                            hintText: 'Last Name',
                            hoverColor: Colors.grey.shade300,
                            prefixIcon: Icon(
                              Icons.person,
                              color: textColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: textColor,),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: textColor,),
                              borderRadius: BorderRadius.circular(12),
                            ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7,),
                      child: TextFormField(
                        controller: commentcontrol,
                        decoration: InputDecoration(
                            fillColor: color,
                            filled: true,
                            hintText: 'Comment',
                            hoverColor: Colors.grey.shade300,
                            prefixIcon: Icon(
                              Icons.comment,
                              color: textColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: textColor,),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: textColor,),
                              borderRadius: BorderRadius.circular(12),
                            ),),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                   uploadData();
                  // log('--------------------------------${userData!.firstName.toString()}------------------------------------------------');
                },
               style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: textColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                ),
               ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}
