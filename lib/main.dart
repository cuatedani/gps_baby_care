import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gps_baby_care/Vistas/Generales/splash_screen.dart';
import 'firebase_options.dart';
import 'Vistas/Generales/BienvenidaView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS BabyCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     // home: Bienvenida(),
      home: SplashScreen(),
    );
  }
}
