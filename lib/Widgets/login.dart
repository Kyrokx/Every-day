import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:every_day/Services/firebaseHelper.dart';
import 'package:every_day/Utils/custonText.dart';
import 'package:every_day/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Utils/showPopUp.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginState();
  }
}

class LoginState extends State<Login> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  late FocusNode email_focus;
  late FocusNode password_focus;

  @override
  void initState() {
    super.initState();
    email_controller = TextEditingController();
    password_controller = TextEditingController();
    email_focus = FocusNode();
    password_focus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    email_controller.dispose();
    password_controller.dispose();
    email_focus.dispose();
    password_focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          /*email_focus.unfocus();
          password_focus.unfocus();*/
          FocusScope.of(context).unfocus();
        });
      },
      child: Scaffold(
          backgroundColor: mainColor,
          body: SingleChildScrollView(
            child: Center(
                child: AutofillGroup(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: height * 0.3,
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                          ),
                          child: Center(
                              child: CustomText(
                                "Oh nice to see you again ! Log in",
                                fontSize: 40.0,
                              ))),
                      //-------------------------------------------------------------------//
                      Container(
                        height: height * 0.7,
                        width: width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0),
                              topRight: Radius.circular(50.0),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // ------------------------EMAIL TEXT FIELD ---------------------//
                            Container(
                              padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                              child: TextField(
                                controller: email_controller,
                                focusNode: email_focus,
                                autofillHints: [AutofillHints.email],
                                cursorColor: mainColor,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                                  ),
                                  label: CustomText(
                                    "Enter your email",
                                    color: Colors.grey,
                                  ),
                                  icon: const Icon(
                                    Icons.email_outlined,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ),

                            // ------------------------PASSWORD TEXT FIELD ---------------------//
                            Container(
                              padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                              child: TextField(
                                controller: password_controller,
                                focusNode: password_focus,
                                autofillHints: [AutofillHints.password],
                                obscureText: true,
                                maxLength: 16,
                                cursorColor: mainColor,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                                  ),
                                  label: CustomText(
                                    "Enter your password",
                                    color: Colors.grey,
                                  ),
                                  icon: const Icon(
                                    Icons.password_outlined,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ),

                            // ------------------------LOGIN BUTTON---------------------//

                            SizedBox(
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    check();
                                  });
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                            side: BorderSide(color: mainColor))),
                                    backgroundColor:
                                    MaterialStatePropertyAll(mainColor)),
                                child: CustomText(
                                  "Login",
                                  fontSize: 30.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          )),
    );
  }

  check()  {
    if (email_controller.text.isNotEmpty || email_controller.text != "") {
      if (password_controller.text.isNotEmpty ||
          password_controller.text != "") {
        setState(() {
          FirebaseHelper()
              .LogIn(context, email_controller.text, password_controller.text)
              .then((value) {
             if(value != null) {
               Navigator.pop(context);
             } else {
               return null;
             }
          });
              /*.whenComplete(() {
            setState(() {
              TextInput.finishAutofillContext();
              //Navigator.pop(context);
            });
          });*/
        });
      } else {
        ShowPopUp().errorPopUp(context, "Please , enter a password");
      }
    } else {
      ShowPopUp().errorPopUp(context, "Please , enter a valid email");
    }
  }

/*check() {
    if (email_controller.text.isNotEmpty &
    password_controller.text.isNotEmpty) {

      setState(() {
        FirebaseHelper().LogIn(context,email_controller.text, password_controller.text).whenComplete(() {
          setState(() {
            Navigator.pop(context);
          });
        });
      });

    } else {
      ShowPopUp().errorPopUp(context, "Please , enter all informations !");
    }
  }*/
}
