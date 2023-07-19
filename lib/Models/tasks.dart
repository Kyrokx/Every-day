import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Member {
  late String author_uid;
  late String name;
  late String description;
  late String task_uid;


  late DocumentReference ref;

  Member(DocumentSnapshot snapshot) {
    ref = snapshot.reference;
    author_uid = snapshot.id;
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
    name = data!["name"];
    description = data!["description"];
    task_uid = data!["task_uid"];
  }

  Map toMap() {
    return {
      "author_uid": author_uid,
      "task_uid": task_uid,
      "name": name,
      "description": description,
    };
  }

}
