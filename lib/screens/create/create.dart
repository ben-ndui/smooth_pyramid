import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_pyramid/intermediaire/inter.dart';
import 'package:smooth_pyramid/screens/connexion/connexion_screen.dart';
import 'package:smooth_pyramid/screens/create/components/create_body.dart';
import 'package:smooth_pyramid/services/google_sign_in.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  // final AuthService _auth = AuthService();
  final player = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<GoogleSignInProvider>(context);
    if (player == null) {
      return Connexion();
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              player.displayName + '\n Hôte',
              style: TextStyle(
                color: Colors.brown,
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          elevation: 0,
          actions: [
            FlatButton.icon(
              onPressed: () async {
                await myProvider.logout();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Inter(),
                  ),
                );
              },
              icon: Icon(
                Icons.logout,
                color: Colors.red,
                size: 12.0,
              ),
              label: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12.0,
                ),
              ),
            )
          ],
        ),
        body: CreateBody(),
      );
    }
  }
}
