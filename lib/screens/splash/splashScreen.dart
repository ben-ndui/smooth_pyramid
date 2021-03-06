import 'package:flutter/material.dart';
import 'package:smooth_pyramid/screens/splash/components/splash_body.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            SplashBody(),
          ],
        ),
      ),
    );
  }
}
