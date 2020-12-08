import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smooth_pyramid/models/CardDeck.dart';
import 'package:smooth_pyramid/models/GameDeck.dart';
import 'package:smooth_pyramid/models/Players.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static List<Player> playersList = new List();
  Player playerI;
  int currPlayer = 0;
  GameDeck gameDeck = new GameDeck();
  CardDeck card;
  String currentCard;
  bool nextScreen = false;

  // create player object based on firebase user
  Player _playerFromFireBase(User player) {
    return player != null
        ? Player(
            player.email,
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

  // sign in anon
  Future signInAnon() async {
    try {
      Firebase.initializeApp();
      User player = (await _auth.signInAnonymously()).user;
      return _playerFromFireBase(player);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // auth change player stream
  Future signInWithName(String name) async {
    try {
      Firebase.initializeApp();
      User player = (await _auth.createUserWithEmailAndPassword(
              email: name, password: "lolololo"))
          .user;
      return _playerFromFireBase(player);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<Player> get user {
    return _auth.authStateChanges().map(_playerFromFireBase);
  }

  // sign in with email and password

  // register with email and password

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
