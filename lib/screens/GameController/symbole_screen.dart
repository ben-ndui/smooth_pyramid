import 'package:flutter/material.dart';
import 'package:smooth_pyramid/models/CardDeck.dart';
import 'package:smooth_pyramid/models/GameDeck.dart';
import 'package:smooth_pyramid/models/Players.dart';
import 'package:smooth_pyramid/screens/GameController/PlayGameMethod.dart';
import 'package:smooth_pyramid/screens/GameController/components/card_symbole_body.dart';
import 'package:smooth_pyramid/screens/home/components/background.dart';

import 'components/gameBody.dart';

class SymboleScreen extends StatefulWidget {
  List<Player> playersList;
  Player currentPlayer;

  int tour;
  int currPlayer;

  CardDeck card;
  bool nextScreen;
  String currentCard;
  String nextScreenBackground;
  String firstBtnImageURL;
  String secondBtnImageURL;
  String nextScreenName;
  String nextScreenMessage;

  GameDeck gameDeck;

  SymboleScreen({
    @required this.playersList,
    @required this.tour,
    @required this.nextScreen,
    @required this.nextScreenBackground,
    @required this.firstBtnImageURL,
    @required this.secondBtnImageURL,
    @required this.nextScreenName,
    @required this.nextScreenMessage,
    @required this.gameDeck,
    @required this.currPlayer,
  });

  @override
  _SymboleScreenState createState() => _SymboleScreenState(
        playersList,
        currentPlayer,
        tour,
        card,
        nextScreen,
        currentCard,
        nextScreenBackground,
        firstBtnImageURL,
        secondBtnImageURL,
        nextScreenName,
        nextScreenMessage,
        gameDeck,
        currPlayer,
      );
}

class _SymboleScreenState extends State<SymboleScreen> {
  List<Player> playersList;
  Player currentPlayer;

  int tour;
  int currPlayer;
  bool nextScreen;

  String currentCard;
  String nextScreenBackground;
  String firstBtnImageURL;
  String secondBtnImageURL;
  String nextScreenName;
  String nextScreenMessage;

  CardDeck card;
  GameDeck gameDeck;
  PlayController playController;

  _SymboleScreenState(
    List<Player> playersList,
    Player currentPlayer,
    int tour,
    CardDeck card,
    bool nextScreen,
    String currentCard,
    String nextScreenBackground,
    String firstBtnImageURL,
    String secondBtnImageURL,
    String nextScreenName,
    String nextScreenMessage,
    GameDeck gameDeck,
    int currPlayer,
  ) {
    this.playersList = playersList;
    this.currentPlayer = currentPlayer;
    this.tour = tour;
    this.currPlayer = currPlayer;
    this.card = card;
    this.nextScreen = nextScreen;
    this.currentCard = currentCard;
    this.nextScreenBackground = nextScreenBackground;
    this.firstBtnImageURL = firstBtnImageURL;
    this.secondBtnImageURL = secondBtnImageURL;
    this.nextScreenName = nextScreenName;
    this.nextScreenMessage = nextScreenMessage;
    this.gameDeck = gameDeck;
    this.playController = PlayController(
      playersList,
      currentPlayer,
      gameDeck,
      card,
      currentCard,
      nextScreen,
      currPlayer,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Current player number dans GAMESCREEN : ${this.currPlayer}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomeBackground(homeBackURL: nextScreenBackground),
          SymboleBody(
            playersList: this.playersList,
            currentPlayer: this.currentPlayer,
            tour: this.tour,
            gameDeck: this.gameDeck,
            card: this.card,
            currentCard: this.currentCard,
            nextScreen: this.nextScreen,
            nextScreenBackground: this.nextScreenBackground,
            firstBtnImageURL: this.firstBtnImageURL,
            secondBtnImageURL: this.secondBtnImageURL,
            nextScreenName: this.nextScreenName,
            nextScreenMessage: this.nextScreenMessage,
            currPlayer: this.currPlayer,
          ),
        ],
      ),
    );
  }
}
