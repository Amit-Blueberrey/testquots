


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:testquots/controller.dart';





 class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();
    String? deviceToken = await getDeviceToken();
    debugPrint("Device FCM Token: $deviceToken");
    

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('app_icon');
    const IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if (_flutterLocalNotificationsPlugin == null) {
      await _flutterLocalNotificationsPlugin
          .initialize(initializationSettings);
      print("thisispush: $initializationSettings");
    }

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
      
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      
      _handleNotificationClick(message);
    });

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      
    // });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
    
    // Listen for notifications received from iOS PushKit
    // platform.setMethodCallHandler((call) {
    //   if (call.method == 'onNotificationReceived') {
    //     final Map<String, dynamic>? notificationData = call.arguments;
    //     if (notificationData != null) {
    //       // Handle notification data and navigate to specific page
    //       handleNotificationData(notificationData);
    //     }
    //   }
    //   return Future.value();
    // });
  }

  

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    await _handleNotificationClick(message);
  }

  void _showLocalNotification(RemoteMessage message) async {
    final data = Data.fromJson(message.data);
    debugPrint("Notification: $data");
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '0',
      'your_channel_name',
      'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      message.messageId as int,
      data.title,
      data.body,
      platformChannelSpecifics,
      payload: data.indexOf,
    );
  }

  Future<String?> getDeviceToken() async {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken();
    return (deviceToken == null) ? "" : deviceToken;
  }

  Future<void> _handleNotificationClick(RemoteMessage message) async {
    final data = await Data.fromJson(message.data);
    String screen = data.screen;
    String title = data.title;
    int? index = int.tryParse(data.indexOf ?? '');

    debugPrint("Notification clicked$screen");
    debugPrint("Notification clicked$title");
    debugPrint("Notification clicked$index");
    debugPrint("Notification clicked END==========>");

    if (screen == 'quots') {
      if (index != null) {
        
        Get.toNamed("/quots");
      }
    } else if (screen == 'profile') {
      if (index != null) {
       Get.toNamed("/profile");
       
      }
    } else if (screen == 'setting') {
      if (index != null) {
        Get.toNamed("/setting");
      }
    }
  }
}

class Data {
  final String title;
  final String body;
  final String screen;
  final String indexOf;

  Data({
    required this.title,
    required this.body,
    required this.screen,
    required this.indexOf,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      screen: json['screen'] ?? '',
      indexOf: json['index'] ?? '',
    );
  }
}










