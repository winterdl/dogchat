import 'package:dogchat/ui/home/home.dart';
import 'package:dogchat/ui/chat/chat.dart';
import 'package:dogchat/ui/my/my.dart';
import 'package:dogchat/ui/auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dogchat/globals.dart';
import 'package:dogchat/dart_html_stub.dart' if (dart.library.html) 'dart:html';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  if (kIsWeb) {
    isPCWeb = RegExp(r'^(Win|Mac)').hasMatch(window.navigator.platform);
    id = Uri.parse(window.location.toString()).queryParameters["id"];
    print("isPCWeb:$isPCWeb:${window.navigator.platform}");
  } else {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('FirebaseMessaging onMessage $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('FirebaseMessaging onLaunch  $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('FirebaseMessaging onResume  $message');
      },
    );
    String token = await _firebaseMessaging.getToken();
    print('FirebaseMessaging token: $token');
  }
  print("ID:$id");
  runApp(
    MaterialApp(
      title: '🐕 Dog Chat -ワンタイムチャット-',
      initialRoute: '/',
      theme: dTheme,
      routes: <String, WidgetBuilder>{
        '/': (_) => new Home(),
        '/chat': (_) => new Chat(),
        '/my': (_) => new My(),
        '/auth': (_) => new Auth(),
      },
    ),
  );
}
