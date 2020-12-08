import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_pyramid/screens/saloon/player_list.dart';
import 'package:smooth_pyramid/services/database.dart';
import 'package:smooth_pyramid/services/google_sign_in.dart';

class SaloonBody extends StatefulWidget {
  @override
  _SaloonBodyState createState() => _SaloonBodyState();
}

class _SaloonBodyState extends State<SaloonBody> {
  final GoogleSignInProvider _auth = GoogleSignInProvider();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DataBaseService().player,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/backgrounds/green.png",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: PlayerList(),
            )
          ],
        ),
      ),
    );
  }
}
