import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_pyramid/models/CardDeck.dart';
import 'package:smooth_pyramid/models/GameDeck.dart';
import 'package:smooth_pyramid/models/Players.dart';

class CreateBody extends StatefulWidget {
  @override
  _CreateBodyState createState() => _CreateBodyState();
}

class _CreateBodyState extends State<CreateBody> {
  List<Player> playersList = new List();
  final player = FirebaseAuth.instance.currentUser;
  Player pl;
  int currPlayer = 0;
  GameDeck gameDeck = new GameDeck();
  CardDeck card;
  String currentCard;
  bool nextScreen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addPlayer(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/video/home12.gif",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 100.0),
            color: Colors.amber,
            width: MediaQuery.of(context).size.width,
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
                              fontSize: 15,
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

  void removePlayer(Player plyer) {
    return setState(() {
      playersList.removeWhere((element) => element.name == plyer.name);
      print(playersList.toString());
    });
  }

  Future<void> addPlayer(BuildContext context) async {
    return setState(() {
      if (player != null) {
        pl = Player(
          player.displayName,
          playersList,
          pl,
          currPlayer,
          gameDeck,
          null,
          null,
          nextScreen,
        );
        playersList.add(pl);
        print(playersList.length);
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
                      'Il y a un proble... ',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Aucun joueur en cours..',
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
