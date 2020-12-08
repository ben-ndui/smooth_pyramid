import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_pyramid/models/Players.dart';
import 'package:smooth_pyramid/screens/connexion/connexion_screen.dart';
import 'package:smooth_pyramid/screens/home/components/CardScrollWidget.dart';
import 'package:smooth_pyramid/screens/home/components/data.dart';
import 'package:smooth_pyramid/screens/jouer/jouer.dart';
import 'package:smooth_pyramid/screens/saloon/saloon.dart';
import 'package:smooth_pyramid/services/auth.dart';
import 'package:smooth_pyramid/services/google_sign_in.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.3;

class _HomeState extends State<Home> {
  var currentPage = images.length - 1.0;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isActive = false;

  PageController controller;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);

    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return AnimatedContainer(
      transform: Matrix4.translationValues(
        xOffset,
        yOffset,
        0,
      )..scale(scaleFactor),
      duration: Duration(milliseconds: 250),
      child: Container(
        // color: Colors.green,
        alignment: Alignment.center,
        child: Stack(
          children: [
            CardScrollWidget(currentPage),
            Positioned.fill(
              child: PageView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //print("lala $index");
                      switch (index) {
                        case 2:
                          Navigator.push(
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
                                pageBuilder:
                                    (context, animation, animationTime) {
                                  return JouerScreen();
                                },
                              ));
                          break;
                        case 1:
                          Navigator.push(
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
                                //Il faut faire la meme chose dans connexion body
                                return Scaffold(
                                  body: ChangeNotifierProvider(
                                    create: (context) => GoogleSignInProvider(),
                                    child: StreamBuilder(
                                      stream: FirebaseAuth.instance
                                          .authStateChanges(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        final player =
                                            Provider.of<GoogleSignInProvider>(
                                                context);
                                        if (player.isSigningIn) {
                                          return buildLoading();
                                        } else if (snapshot.hasData) {
                                          return Saloon();
                                        } else {
                                          return Connexion();
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                          break;
                        case 0:
                          if (isActive == false) {
                            setState(() {
                              xOffset = 150;
                              yOffset = 50;
                              scaleFactor = 0.9;
                            });
                            isActive = true;
                          } else {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isActive = false;
                            });
                            isActive = false;
                          }
                          break;
                        default:
                      }
                    },
                    child: Container(
                      child: Text(""),
                    ),
                  );
                },
                controller: controller,
                reverse: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoading() => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[50],
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}

// Navigator.push(
//   context,
//   PageRouteBuilder(
//     transitionDuration: Duration(
//       milliseconds: 1000,
//     ),
//     transitionsBuilder:
//         (context, animation, animationTime, child) {
//       animation = CurvedAnimation(
//         parent: animation,
//         curve: Curves.elasticInOut,
//       );
//       return ScaleTransition(
//         alignment: Alignment.center,
//         scale: animation,
//         child: child,
//       );
//     },
//     // pageBuilder: (context, animation, animationTime) {
//     //   return StreamProvider<Player>.value(
//     //     value: AuthService().user,
//     //     child: Scaffold(
//     //       body: Saloon(),
//     //     ),
//     //   );
//     // },
//     pageBuilder: (context, animation, animationTime) {//Il faut faire la meme chose dans connexion body
//       return Scaffold(
//         body: ChangeNotifierProvider(
//           create: (context) => GoogleSignInProvider(),
//           child: StreamBuilder(
//             stream: FirebaseAuth.instance
//                 .authStateChanges(),
//             builder: (BuildContext context,
//                 AsyncSnapshot<dynamic> snapshot) {
//               final player =
//                   Provider.of<GoogleSignInProvider>(
//                       context);
//               if (player.isSigningIn) {
//                 return buildLoading();
//               } else if (snapshot.hasData) {
//                 return Saloon();
//               } else {
//                 return Connexion();
//               }
//             },
//           ),
//         ),
//       );
//     },
//   ),
// );
