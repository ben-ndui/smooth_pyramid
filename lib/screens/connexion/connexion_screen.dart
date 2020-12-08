import 'package:flutter/material.dart';
import 'package:smooth_pyramid/screens/connexion/components/connexion_body.dart';

class Connexion extends StatefulWidget {
  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConnexionBody(),
    );
  }
}
