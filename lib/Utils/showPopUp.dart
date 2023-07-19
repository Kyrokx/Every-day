import 'dart:io';
import 'package:every_day/Services/firebaseHelper.dart';
import 'package:every_day/Utils/custonText.dart';
import 'package:every_day/constant.dart';
import 'package:flutter/material.dart';

class ShowPopUp {



  Future errorPopUp(@required context, @required message) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return AlertDialog(
            icon: Icon(Icons.error),
            backgroundColor: mainColor,
            title: CustomText("Error"),
            content: CustomText(message),
          );
        });
  }

  Future logOut(@required context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            icon: Icon(Icons.logout),
            backgroundColor: mainColor,
            title: CustomText("Log out"),
            content: CustomText("Do you really want to log-out ?"),
            actions: [
              _noLogOutButton(context),
              _yesLogOutButton(context),
            ],
          );
        });
  }

  _yesLogOutButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          FirebaseHelper().signOut(context);
          Navigator.pop(context);
        },
        child: CustomText(
          "Yes, I do",
          color: Colors.red,
        ));
  }

  _noLogOutButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: CustomText(
          "No, I don't",
          color: Colors.green,
        ));
  }


  Future deleteAcount(@required context, String uid) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            icon: Icon(Icons.delete),
            backgroundColor: mainColor,
            title: CustomText("Delete"),
            content: CustomText("⚠ | Be carefull,do you really want to delete your account ?. This action is irreversible"),
            actions: [
              _noDeleteButton(context),
              _yesDeleteButton(context,uid),
            ],
          );
        });
  }

  _yesDeleteButton(BuildContext context,String uid) {
    return TextButton(
        onPressed: () {
          FirebaseHelper().deleteUser(uid);
          Navigator.pop(context);
        },
        child: CustomText(
          "Yes, I do",
          color: Colors.red,
        ));
  }

  _noDeleteButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: CustomText(
          "No, I don't",
          color: Colors.green,
        ));
  }

  Future taskAdded(BuildContext context) async {
    final snackBar = SnackBar(
      backgroundColor: mainColor,
      content: CustomText("Tasks added"),
      action: SnackBarAction(
        backgroundColor: mainColor,
        label: 'dismiss',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future taskDeleted(BuildContext context) async {
    final snackBar = SnackBar(
      backgroundColor: mainColor,
      content: CustomText("Tasks deleted"),
      action: SnackBarAction(
        backgroundColor: mainColor,
        label: 'dismiss',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
