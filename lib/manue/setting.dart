import 'package:flutter/material.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  @override
  Widget build(BuildContext context) {
    double widthS = MediaQuery.of(context).size.width;
    double heightS = MediaQuery.of(context).size.height;
    return Scaffold(
       appBar: AppBar(title: Text("setting"),),
      body: PageView.builder(itemCount: 300,scrollDirection: Axis.vertical,
        itemBuilder: (context ,index ){
        return Container(
        child:  Center(child: Text("setting $index")),
      
      );
      }),
    );
  }
}