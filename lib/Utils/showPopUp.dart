import 'package:every_day/Models/member.dart';
import 'package:every_day/Services/firebaseHelper.dart';
import 'package:every_day/Utils/customText.dart';
import 'package:every_day/Utils/yesButton.dart';
import 'package:every_day/constant.dart';
import 'package:flutter/material.dart';

class ShowPopUp {



  Future errorPopUp(context, message) async {
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

  Future logOut(context) async {
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
              no(context),
              yes(context),
            ],
          );
        });
  }

  Widget yes(BuildContext ctx){
    return YesButton(
        title: "Yes, I do ",
        color: Colors.red,
        onPressed: () {
          FirebaseHelper().signOut(ctx);
          Navigator.pop(ctx);
        },
    );
  }

  Widget no(BuildContext ctx){
    return YesButton(
      title: "Yes, I don't ",
      color: Colors.green,
      onPressed: () {
        Navigator.pop(ctx);
      },
    );
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


  //TextEditingController newUserName_controller = TextEditingController();

  Future changeUsername(context, Member member, TextEditingController newUserName_controller) async {
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
              noChange(context),
              yesChange(context,newUserName_controller),
            ],
          );
        });
  }

  Widget yesChange(BuildContext ctx,TextEditingController newUserName_controller) {
    return YesButton(
        title: "Yes, I do ",
        color: Colors.green,
        onPressed: () {
          if (newUserName_controller.text.isNotEmpty &
              !newUserName_controller.text.contains(" ")) {
            FirebaseHelper().changeUsername(newUserName_controller.text);
            Navigator.pop(ctx);
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

            ScaffoldMessenger.of(ctx).showSnackBar(snackBarChanged);
          } else {
            Navigator.pop(ctx);
            final snackBarError = SnackBar(
              backgroundColor: mainColor,
              content: CustomText("Oups, there is an error ( Try to remove space(s) )"),
              action: SnackBarAction(
                backgroundColor: mainColor,
                label: 'dismiss',
                onPressed: () {
                  null;
                },
              ),
            );

            ScaffoldMessenger.of(ctx).showSnackBar(snackBarError);
          }

        }
    );
  }

  Widget noChange(BuildContext ctx){
    return YesButton(
      title: "Cancel",
      color: Colors.red,
      onPressed: () {
        Navigator.pop(ctx);
      },
    );
  }

}
