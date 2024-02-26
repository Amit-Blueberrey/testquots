import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    double widthS = MediaQuery.of(context).size.width;
    double heightS = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("profile"),),
      body: PageView.builder(itemCount: 300,scrollDirection: Axis.vertical,
        itemBuilder: (context ,index ){
        return Container(
        child: Center(child: Text("profile $index")),
      );
      }),
    );
  }
}