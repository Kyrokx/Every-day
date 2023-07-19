import 'package:email_validator/email_validator.dart';
import 'package:every_day/Services/firebaseHelper.dart';
import 'package:every_day/Utils/custonText.dart';
import 'package:every_day/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utils/showPopUp.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SignupState();
  }
}

class SignupState extends State<Signup> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController username_controller = TextEditingController();

  late FocusNode email_focus;
  late FocusNode password_focus;
  late FocusNode username_focus;

  @override
  void initState() {
    super.initState();
    email_controller = TextEditingController();
    password_controller = TextEditingController();
    username_controller = TextEditingController();
    email_focus = FocusNode();
    password_focus = FocusNode();
    username_focus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    email_controller.dispose();
    password_controller.dispose();
    username_controller.dispose();
    email_focus.dispose();
    password_focus.dispose();
    username_focus.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;


    return Scaffold(
        backgroundColor: mainColor,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: height * 0.3,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                        child: CustomText(
                          "Hello, first time ?\n Sign Up", fontSize: 40.0,)
                    )
                ),
                //-------------------------------------------------------------------//
                Container(
                  height: height * 0.7,
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      // ------------------------USERNAME TEXT FIELD ---------------------//
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.white)),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.5,
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          controller: username_controller,
                          focusNode: username_focus,
                          decoration: InputDecoration(
                            hintText: "Mark",
                            label: CustomText("Enter your username",
                              color: Colors.white,),
                            icon: const Icon(Icons.person),
                          ),
                        ),
                      ),

                      // ------------------------EMAIL TEXT FIELD ---------------------//
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.white)),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.5,
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          controller: email_controller,
                          focusNode: email_focus,
                          decoration: InputDecoration(
                            hintText: "example@example.com",
                            label: CustomText("Enter your email",
                              color: Colors.white,),
                            icon: const Icon(Icons.email_outlined),
                          ),
                        ),
                      ),

                      // ------------------------PASSWORD TEXT FIELD ---------------------//
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.white)),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.5,
                        child: TextField(
                          textInputAction: TextInputAction.done,
                          controller: password_controller,
                          focusNode: password_focus,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "example4321",
                            label: CustomText("Enter your password",
                              color: Colors.white,),
                            icon: const Icon(Icons.password_outlined),
                          ),
                        ),
                      ),

                      // ------------------------LOGIN BUTTON---------------------//

                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 15,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
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
                                      borderRadius: BorderRadius.circular(50.0),
                                      side: BorderSide(color: mainColor))),
                              backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
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
        )
    );
  }

  check() {
    if (email_controller.text.isNotEmpty & password_controller.text.isNotEmpty & username_controller.text.isNotEmpty) {
      if(EmailValidator.validate(email_controller.text) == true) {
        if(password_controller.text.length > 8){

            setState(() {
              FirebaseHelper().signUp(context,email_controller.text, password_controller.text, username_controller.text).whenComplete(() {
                setState(() {
                  Navigator.pop(context);
                });
              });
            });



        } else {
          ShowPopUp().errorPopUp(context, "Password not secure (>8)");
        }
      } else {
        ShowPopUp().errorPopUp(context, "Email invalid");
      }

    } else {
      ShowPopUp().errorPopUp(context, "Please , enter all informations !");
    }
  }

}