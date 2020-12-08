import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_pyramid/models/CardDeck.dart';
import 'package:smooth_pyramid/models/GameDeck.dart';
import 'package:smooth_pyramid/models/Players.dart';
import 'package:smooth_pyramid/screens/connexion/connexion_screen.dart';
import 'package:smooth_pyramid/screens/create/create.dart';
import 'package:smooth_pyramid/screens/saloon/saloon.dart';
import 'package:smooth_pyramid/services/google_sign_in.dart';

class ConnexionBody extends StatefulWidget {
  @override
  _ConnexionBodyState createState() => _ConnexionBodyState();
}

class _ConnexionBodyState extends State<ConnexionBody> {
  TextEditingController controller = TextEditingController();
  String username = '';

  final currentPlayer = FirebaseAuth.instance.currentUser;

  List<Player> playersList = new List();
  Player player;
  int currPlayer = 0;
  GameDeck gameDeck = new GameDeck();
  CardDeck card;
  String currentCard;
  bool nextScreen = false;

  // final AuthService _auth = AuthService();
  // final _formKey = GlobalKey<FormState>();
  // String error = '';

  @override
  Widget build(BuildContext context) {
    // var player = Provider.of<Player>(context);
    return Container(
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/video/beer3.gif",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 12,
            ),
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width / 2,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2.5,
                    left: MediaQuery.of(context).size.width / 6,
                  ),
                  child: RaisedButton(
                    elevation: 0.0,
                    color: Colors.yellow,
                    onPressed: () async {
                      //Declaration du provider et mise en marche du procedure de connexion via google
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.signInWithGoogle(true);
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
                                  stream:
                                      FirebaseAuth.instance.authStateChanges(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    final player =
                                        Provider.of<GoogleSignInProvider>(
                                            context);
                                    if (player.isSigningIn) {
                                      return buildLoading();
                                    } else if (snapshot.hasData) {
                                      return CreateScreen();
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
                    },
                    child: Text(
                      "Créer une partie",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 12,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width / 2,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2,
                          left: MediaQuery.of(context).size.width / 12,
                        ),
                        child: RaisedButton(
                          elevation: 0.0,
                          color: Colors.green,
                          onPressed: () async {
                            //Declaration du provider et mise en marche du procedure de connexion via google
                            final provider = Provider.of<GoogleSignInProvider>(
                                context,
                                listen: false);
                            provider.signInWithGoogle(false);
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
                                  //Il faut faire la meme chose dans connexion body
                                  return Scaffold(
                                    body: ChangeNotifierProvider(
                                      create: (context) =>
                                          GoogleSignInProvider(),
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
                          },
                          child: Text(
                            "Joindre",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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

  void removePlayer(Player player) {
    return setState(() {
      playersList.removeWhere((element) => element.name == player.name);
      print(playersList.toString());
    });
  }

  Future<void> addPlayer(BuildContext context) async {
    return setState(() {
      player = Player(
        currentPlayer.displayName,
        playersList,
        player,
        currPlayer,
        gameDeck,
        null,
        null,
        nextScreen,
      );
      playersList.add(player);
      print(playersList.length);
    });
  }
}
