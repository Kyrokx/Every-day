import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:every_day/Utils/showPopUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseHelper {
  final user_instance = FirebaseAuth.instance;

  Future LogIn(
      BuildContext context, String email, String password) async {
    try {
      final userCredential = await user_instance.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch  (e) {
      ShowPopUp().errorPopUp(context, e.message);
    }
  }


  Future signUp(BuildContext context, String email, String password,
      String username) async {
    try {
      final userCredential = await user_instance.createUserWithEmailAndPassword(
          email: email, password: password);
      final User? user = userCredential.user;

      Map<String, dynamic> memberMap = {
        "username": username,
        "email": email,
        "uid": user?.uid,
        "date_created": DateTime.now(),
      };

      addUserToFirebase(memberMap);
      return user;
    } on FirebaseAuthException catch (e) {
      ShowPopUp().errorPopUp(context, e.message);
    }
  }

  static final firestroreInstance = FirebaseFirestore.instance;
  final fire_user = firestroreInstance.collection("Users");

  addUserToFirebase(Map<String, dynamic> mapp) {
    fire_user.doc(mapp["uid"]).set(mapp);
  }

  getUserInfo(String uid) {
    final userInfo = fire_user.doc(uid).get();
    print(userInfo);
  }

  Future signOut(BuildContext context) async {
    try {
      await user_instance.signOut();
    } on FirebaseAuthException catch (e) {
      ShowPopUp().errorPopUp(context, e.message);
    }
  }

  Future addTask(String name, String description, DateTime date_finish_before) async  {

    Map<String, dynamic> taskMap = {
      "name": name,
      "description": description,
      "date_created": DateTime.now(),
      "author_uid": user_instance.currentUser!.uid,
      "task_uid": "",
      "date_finish_before": date_finish_before,
    };
    await addTaskToFirebase(taskMap);
  }

  Future addTaskToFirebase(Map<String, dynamic> mapp) async {
    final taks_collection = fire_user.doc(user_instance.currentUser!.uid).collection("tasks");

    taks_collection.add(mapp).then((value) async {

      Map<String, dynamic> taskMap = {
        "task_uid": value.id,
      };

      await taks_collection.doc(value.id).update(taskMap);
    });
  }

  Future deleteTask(String taskUid) async {
    final taks_collection = fire_user.doc(user_instance.currentUser!.uid).collection("tasks");
    await taks_collection.doc(taskUid).delete();
  }

  Future changeUsername(String newUsername) async {
    final username = fire_user.doc(user_instance.currentUser!.uid);
    await username.update({'username': newUsername});
    return true;
  }

}
