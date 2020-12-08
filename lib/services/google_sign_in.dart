import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smooth_pyramid/models/CardDeck.dart';
import 'package:smooth_pyramid/models/GameDeck.dart';
import 'package:smooth_pyramid/models/Players.dart';
import 'package:smooth_pyramid/services/database.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSigningIn;

  static List<Player> playersList = new List();
  Player playerI;
  int currPlayer = 0;
  GameDeck gameDeck = new GameDeck();
  CardDeck card;
  String currentCard;
  bool nextScreen = false;

  // Google Sign In
  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future signInWithGoogle(bool isHote) async {
    isSigningIn = true;

    final player = await googleSignIn.signIn();

    if (player == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await player.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      User playerRes = (await _auth.signInWithCredential(credential)).user;
      await DataBaseService(uid: playerRes.uid)
          .updateUserData(playerRes.displayName, isHote);

      isSigningIn = false;

      return _playerFromFireBase(playerRes);
    }
  }

  Future logout() async {
    await googleSignIn.disconnect();
    _auth.signOut();
  }

  Player _playerFromFireBase(User player) {
    return player != null
        ? Player(
            player.displayName,
            playersList,
            playerI,
            currPlayer,
            gameDeck,
            card,
            currentCard,
            nextScreen,
          )
        : null;
  }
}
