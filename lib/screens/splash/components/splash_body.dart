import 'package:flutter/material.dart';
import 'package:smooth_pyramid/intermediaire/inter.dart';
import 'package:smooth_pyramid/models/Splash.dart';

class SplashBody extends StatefulWidget {
  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: splashList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                child: Image.asset(
                  "assets/splashScreens/${splashList[index].name}.png",
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        Container(
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(
            top: 40,
            right: 15,
          ),
          child: FlatButton(
            color: Colors.white.withOpacity(0.1),
            padding: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            onPressed: () => Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(
                    milliseconds: 1000,
                  ),
                  transitionsBuilder:
                      (context, animation, animationTime, child) {
                    animation = CurvedAnimation(
                      parent: animation,
                      curve: Curves.elasticInOut,
                    );
                    return ScaleTransition(
                      alignment: Alignment.center,
                      scale: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, animationTime) {
                    return Inter();
                  },
                )),
            child: Text(
              "Jouer",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
