import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smooth_pyramid/screens/loader/loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smooth Pyramid',
      theme: ThemeData(
        fontFamily: 'Arkhip_font',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Loader(), //Connexion()
      debugShowCheckedModeBanner: false,
    );
  }
}
