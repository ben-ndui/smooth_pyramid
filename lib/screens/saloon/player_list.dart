import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class PlayerList extends StatefulWidget {
  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  @override
  Widget build(BuildContext context) {
    final player = Provider.of<QuerySnapshot>(context);

    // print(player);
    for (var player in player.docs) {
      print(player.data());
    }

    return Container();
  }
}
