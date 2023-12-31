import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  late String uid;
  late String username;
  late String email;


  late DocumentReference ref;

  Member(DocumentSnapshot snapshot) {
    ref = snapshot.reference;
    uid = snapshot.id;
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    username = data!["username"];
    email = data!["email"];

  }

  Map toMap() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
    };
  }

}
