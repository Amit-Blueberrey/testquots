import 'package:flutter/material.dart';
import 'package:get/get.dart';

class manue extends StatefulWidget {
  const manue({super.key});

  @override
  State<manue> createState() => _manueState();
}

class _manueState extends State<manue> {
  @override
  Widget build(BuildContext context) {
    double widthS = MediaQuery.of(context).size.width;
    double heightS = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Manue")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: heightS*0.02),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed("/profile");
              },
              child: Container(
                height: heightS*0.15,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(15)),
                child: const Center(child: Text("profile")),
              ),
            ),
            SizedBox(height: heightS*0.02,),
            InkWell(
              onTap: () {
                Get.toNamed("/setting");
              },
              child: Container(
                height: heightS*0.15,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(15)),
                child: const Center(child: Text("setting")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}