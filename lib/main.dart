import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:testquots/home.dart';
import 'package:testquots/manue/manue.dart';
import 'package:testquots/manue/profile.dart';
import 'package:testquots/manue/setting.dart';
import 'package:testquots/push_notification.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const MyApp(initialRoute: "/quots"));
  
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: "/quots", page: () => home()),
        GetPage(name: "/manue", page: () => manue()),
        GetPage(name: "/profile", page: () => profile()),
        GetPage(name: "/setting", page: () => setting()),
        
      ],
      
    );
  }
}

