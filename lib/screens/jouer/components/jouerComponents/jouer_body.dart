import 'package:flutter/material.dart';
import 'package:smooth_pyramid/models/CardDeck.dart';
import 'package:smooth_pyramid/models/GameDeck.dart';
import 'package:smooth_pyramid/models/Players.dart';
import 'package:smooth_pyramid/screens/GameController/game.dart';
import 'package:smooth_pyramid/screens/home/components/background.dart';
import 'package:smooth_pyramid/screens/jouer/components/customDialogBox.dart';

class JouerBody extends StatefulWidget {
  @override
  _JouerBodyState createState() => _JouerBodyState();
}

class _JouerBodyState extends State<JouerBody> {
  var _controller = TextEditingController();
  List<Player> playersList = new List();
  Player player;
  int currPlayer = 0;
  GameDeck gameDeck = new GameDeck();
  CardDeck card;
  String currentCard;
  bool nextScreen = false;
  String temp;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          HomeBackground(homeBackURL: "assets/backgrounds/play.png"),
          Padding(
            padding: const EdgeInsets.only(
              top: 100,
              left: 25.0,
              right: 25.0,
            ),
            child: TextField(
              autofocus: true,
              onChanged: (value) {
                temp = value;
              },
              onSubmitted: (value) {
                addPlayer(context);
                this.initState();
                print(playersList.length);
              },
              cursorColor: Colors.white,
              cursorHeight: 25.0,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Entrez un joueur",
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.5,
                    style: BorderStyle.solid,
                  ),
                ),
                suffixIcon: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // added line
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.add),
                      onPressed: () {
                        addPlayer(context);
                        this.initState();
                        print(playersList.length);
                      },
                    ),
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.play_arrow_sharp),
                      onPressed: () {
                        setState(
                          () {
                            this.gameDeck.initDeck();
                            if (this.playersList.length > 0) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: Duration(
                                    milliseconds: 1000,
                                  ),
                                  transitionsBuilder: (context, animation,
                                      animationTime, child) {
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
                                    return GameScreen(
                                      playersList: this.playersList,
                                      tour: 1,
                                      nextScreen: this.nextScreen,
                                      nextScreenBackground:
                                          "assets/backgrounds/fisrt.png",
                                      firstBtnImageURL:
                                          "assets/backgrounds/components/redChoice.png",
                                      secondBtnImageURL:
                                          "assets/backgrounds/components/blackChoice.png",
                                      nextScreenName: "PlusOuMoinsScreen",
                                      nextScreenMessage:
                                          "Allez hop, \n PLUS or MINUS !!",
                                      gameDeck: this.gameDeck,
                                      currPlayer: 0,
                                    );
                                  },
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                    title: "Bruuuh",
                                    descriptions:
                                        "On peut pas jouer la, tu n'as entré aucun joueur.. ",
                                    text: "Okay",
                                  );
                                },
                              );
                            }
                            print(playersList.toString());
                          },
                        );
                      },
                    ),
                  ],
                ),
                focusColor: Colors.white,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 300.0),
            // color: Colors.green,
            height: MediaQuery.of(context).size.height / 2,
            child: ListView(
              shrinkWrap: true,
              children: playersList
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            e.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              removePlayer(e);
                              print(playersList.length);
                            },
                            child: Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  void removePlayer(Player e) {
    return setState(() {
      playersList.removeWhere((element) => element.name == e.name);
      temp = null;
      print(playersList.toString());
    });
  }

  Future<void> addPlayer(BuildContext context) async {
    return setState(() {
      if (temp != null) {
        player = Player(
          temp,
          playersList,
          player,
          currPlayer,
          gameDeck,
          null,
          null,
          nextScreen,
        );
        playersList.add(player);
        _controller.clear();
        print(playersList.length);
        temp = null;
      } else {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Wow !!!',
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      'Tu n\'as pas entrez de nom !!',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Entre le nom d\'un joueur !!',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    '🍻',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }
}
