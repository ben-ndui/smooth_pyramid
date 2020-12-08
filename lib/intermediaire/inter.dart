import 'package:flutter/material.dart';
import 'package:smooth_pyramid/screens/home/components/background.dart';
import 'package:smooth_pyramid/screens/home/home.dart';
import 'package:smooth_pyramid/screens/jouer/edit.dart';
import 'package:smooth_pyramid/screens/loader/loader.dart';

class Inter extends StatefulWidget {
  const Inter({
    Key key,
  }) : super(key: key);

  @override
  _InterState createState() => _InterState();
}

class _InterState extends State<Inter> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      child: Stack(
        children: [
          EditScreen(),
          HomeBackground(homeBackURL: "assets/video/beer3.gif"),
          AnimeBackground(imageURL: "assets/video/home6.gif"),
          Home(),
        ],
      ),
    );
  }
}
