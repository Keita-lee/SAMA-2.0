import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:sama/Myhome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyCVtEWeZAl8jvB2Xj_A1_48cuSankMxUAQ",
      authDomain: "sama-959a2.firebaseapp.com",
      projectId: "sama-959a2",
      storageBucket: "sama-959a2.appspot.com",
      messagingSenderId: "393242211465",
      appId: "1:393242211465:web:b6c2d02f372dc9ec138258",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1,
      child: MaterialApp(
        home: MyHome(),
      ),
    );
  }
}
