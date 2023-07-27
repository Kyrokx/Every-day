import 'dart:io';
import 'package:every_day/Models/member.dart';
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


  Future deleteAcount(@required context,) async {
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
              _yesDeleteButton(context),
            ],
          );
        });
  }

  _yesDeleteButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          FirebaseHelper().deleteUser();
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


  TextEditingController newUserName_controller = TextEditingController();

  Future changeUsername(@required context, @required Member member) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            //icon: Icon(Icons.drive_file_rename_outline_outlined),
            backgroundColor: mainColor,
            title: CustomText("Change useranme"),
            content:  Container(
              padding:
              const EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextField(
                controller: newUserName_controller,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.0)),
                    borderSide:
                    BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.black, width: 2.0),
                  ),
                  hintText: member.username,
                  label: CustomText(
                    "Enter your new username",
                    color: Colors.black,
                  ),
                  icon: const Icon(
                    Icons.drive_file_rename_outline_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            actions: [
              _noChangeButton(context),
              _yesChangeButton(context),
            ],
          );
        });
  }

  _yesChangeButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          if(newUserName_controller.text.isNotEmpty || newUserName_controller.text != "" || newUserName_controller.text != null || !newUserName_controller.text.contains(" ")){
            FirebaseHelper().changeUsername(newUserName_controller.text);
            Navigator.pop(context);
            //---------------------------------------------//

            final snackBarChanged = SnackBar(
              backgroundColor: mainColor,
              content: CustomText("Username changed"),
              action: SnackBarAction(
                backgroundColor: mainColor,
                label: 'dismiss',
                onPressed: () {
                  null;
                },
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBarChanged);


          } else {
            Navigator.pop(context);
            final snackBarError = SnackBar(
              backgroundColor: mainColor,
              content: CustomText("Oups, there is an error"),
              action: SnackBarAction(
                backgroundColor: mainColor,
                label: 'dismiss',
                onPressed: () {
                  null;
                },
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBarError);

          }
        },
        child: CustomText(
          "Save",
          color: Colors.green,
        ));
  }

  _noChangeButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: CustomText(
          "Cancel",
          color: Colors.red,
        ));
  }

}
