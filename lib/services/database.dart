import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String uid;

  DataBaseService({
    this.uid,
  });
  // collection reference
  final CollectionReference players =
      FirebaseFirestore.instance.collection("players");

  Future updateUserData(String name, bool isHote) async {
    return await players.doc(uid).set({
      'name': name,
      'isHote': isHote,
    });
  }

  // get players stream
  Stream<QuerySnapshot> get player {
    return players.snapshots();
  }
}
