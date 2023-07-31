import 'package:email_validator/email_validator.dart';
import 'package:every_day/Services/firebaseHelper.dart';
import 'package:every_day/Utils/customText.dart';
import 'package:every_day/constant.dart';
import 'package:flutter/material.dart';

import '../Utils/showPopUp.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  late TextEditingController email_controller;
  late TextEditingController password_controller;
  late TextEditingController username_controller;

  late FocusNode email_focus;
  late FocusNode password_focus;
  late FocusNode username_focus;

  @override
  void initState() {
    email_controller = TextEditingController();
    password_controller = TextEditingController();
    username_controller = TextEditingController();
    email_focus = FocusNode();
    password_focus = FocusNode();
    username_focus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    email_controller.dispose();
    password_controller.dispose();
    username_controller.dispose();
    email_focus.dispose();
    password_focus.dispose();
    username_focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        setState(() {
          FocusScope.of(context).unfocus();
        });
      },
      child: Scaffold(
          backgroundColor: mainColor,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: height * 0.3,
                      child: Center(
                          child: CustomText(
                        "Hello, first time ?\n Sign Up",
                        fontSize: 40.0,
                      )
                      )
                  ),
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
                        // ------------------------USERNAME TEXT FIELD ---------------------//
                        Container(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextField(
                            controller: username_controller,
                            focusNode: username_focus,
                            cursorColor: mainColor,
                            textInputAction: TextInputAction.next,
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
                                "Enter your username",
                                color: Colors.grey,
                              ),
                              icon: const Icon(
                                Icons.person,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),

                        // ------------------------EMAIL TEXT FIELD ---------------------//
                        Container(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextField(
                            controller: email_controller,
                            focusNode: email_focus,
                            cursorColor: mainColor,
                            textInputAction: TextInputAction.next,
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
                            obscureText: true,
                            maxLength: 16,
                            cursorColor: mainColor,
                            textInputAction: TextInputAction.done,
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
                          height: height / 15,
                          width: width / 1.3,
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
                              "SignUp",
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
            ),
          )),
    );
  }

  check() async {
    if (username_controller.text.isNotEmpty || username_controller.text != "") {
      if (EmailValidator.validate(email_controller.text) == true) {
        if (password_controller.text.isNotEmpty ||
            password_controller.text != "") {
          if (password_controller.text.length >= 8) {
            setState(() async {
              await FirebaseHelper()
                  .signUp(context, email_controller.text,
                      password_controller.text, username_controller.text)
                  .whenComplete(() {
                setState(() async {
                  Navigator.pop(context);
                });
              });
            });
          } else {
            ShowPopUp().errorPopUp(
                context, "you password must be longer than 8 character");
          }
        } else {
          ShowPopUp().errorPopUp(context, "Please , enter a password");
        }
      } else {
        ShowPopUp().errorPopUp(context, "Please , enter a valid email");
      }
    } else {
      ShowPopUp().errorPopUp(context, "Please , enter a username");
    }
  }
}
