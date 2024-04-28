// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    required this.text,
    required this.image,
    required this.routname,
    super.key,
  });
  String text, image, routname;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(routname);
      },
      child: Stack(
        children: [
          Container(
            height: 175,
            width: 175,
            decoration: BoxDecoration(
              // border: Border.all(),
              // boxShadow: [],
              borderRadius: BorderRadius.circular(35),
              color: Color(0xff9b9ca3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(
                //   Icons.local_shipping,
                //   color: Colors.white,
                //   size: 110,
                // ),
                Image.asset(
                  image,
                  height: 110,
                  width: 110,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(),
            child: Container(
              // child:
              height: 125,
              width: 175,
              decoration: BoxDecoration(
                // border: Border.all(),
                // boxShadow: [],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                color: Colors.black,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color.fromARGB(130, 255, 255, 255),
                    Colors.white38,
                    Colors.white24,
                    const Color.fromARGB(1, 255, 255, 255),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
