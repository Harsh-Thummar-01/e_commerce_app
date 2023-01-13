// ignore_for_file: public_member_api_docs, inference_failure_on_instance_creation, lines_longer_than_80_chars

import 'package:e_commerce_app/categories/bag_page.dart';
import 'package:e_commerce_app/categories/jecket_page.dart';
import 'package:e_commerce_app/categories/mobile_page.dart';
import 'package:e_commerce_app/categories/shose_page.dart';
import 'package:e_commerce_app/categories/watch_page.dart';
import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:flutter/material.dart';


class Categories extends StatelessWidget {
  const Categories({super.key});

  
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ShosePage();
              },),);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/1.png',width: 40,height: 40,),
                  const SizedBox(width: 5,),
                  const Text('Shose',style: TextStyle(
                    fontSize: 17,
                  ),),
              ],),
            ),
          ),



          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const WatchPage();
              },),);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/2.png',width: 40,height: 40,),
                  const SizedBox(width: 5,),
                  const Text('Watch',style: TextStyle(
                    fontSize: 17,
                  ),),
              ],),
            ),
          ),



          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const BagPage();
              },),);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/3.png',width: 40,height: 40,),
                  const SizedBox(width: 5,),
                  const Text('Bag',style: TextStyle(
                    fontSize: 17,
                  ),),
              ],),
            ),
          ),




          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MobilePage();
              },),);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/4.png',width: 40,height: 40,),
                  const SizedBox(width: 5,),
                  const Text('Mobile',style: TextStyle(
                    fontSize: 17,
                  ),),
              ],),
            ),
          ),




          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const JecKetPage();
              },),);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Image.asset('assets/images/5.png',width: 40,height: 40,),
                  const SizedBox(width: 5,),
                  const Text('Jecket',style: TextStyle(
                    fontSize: 17,
                  ),),
              ],),
            ),
          ),
          
        ],
      ),
    );
  }
}
