import 'dart:ffi';

import 'package:every_day/Utils/custonText.dart';
import 'package:every_day/Widgets/login.dart';
import 'package:every_day/Widgets/signup.dart';
import 'package:flutter/material.dart';
import 'package:every_day/constant.dart';

class Connection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ConnectionState();
  }
}

class ConnectionState extends State<Connection> {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: mainColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: height * 0.3,
                child: Image.asset("assets/logo_rounded.png",fit: BoxFit.cover,),
              ),
              CustomText("Every Day", fontSize: 70.0),
              CustomText("Manage all your daily habits", fontSize: 20.0,),
              const Divider(
                thickness: 10.0,
                color: Colors.white,
                indent: 55.0,
                endIndent: 55.0,
              ),


              Container(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    });
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: BorderSide(color: mainColor))),
                      backgroundColor:
                      MaterialStatePropertyAll(secondColor)),
                  child: CustomText(
                    "Log-in",
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                    });
                  },
                  style: ButtonStyle(
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )),
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
        )
    );
  }
}