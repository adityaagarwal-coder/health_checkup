import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_checkup/screens/book_appointment.dart';
import 'package:health_checkup/screens/home.dart';
import 'package:health_checkup/screens/success_screen.dart';
import 'screens/mycart.dart';
import 'utils/database.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyC7E-jls0bS2zmawoOJyEAoZHRoGIZbtwQ",
          appId: "1:527121950787:web:806cd627bcf48201baccf6",
          messagingSenderId: "527121950787",
          projectId: "health-checkup-b5fd6"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
