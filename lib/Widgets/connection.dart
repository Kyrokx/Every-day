import 'package:every_day/Utils/customText.dart';
import 'package:every_day/Widgets/login.dart';
import 'package:every_day/Widgets/signup.dart';
import 'package:flutter/material.dart';
import 'package:every_day/constant.dart';

class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  State<StatefulWidget> createState() {
    return ConnectionState();
  }
}

class ConnectionState extends State<Connection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: height * 0.3,
                child: Image.asset(
                  "assets/logo_rounded.png",
                  fit: BoxFit.cover,
                ),
              ),
              CustomText("Every Day", fontSize: 70.0),
              CustomText(
                "Manage all your daily habits",
                fontSize: 20.0,
              ),
              const Divider(
                thickness: 5.0,
                color: Colors.white,
                indent: 55.0,
                endIndent: 55.0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 1.3,
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: secondColor))),
                      backgroundColor: MaterialStatePropertyAll(secondColor)),
                  child: CustomText(
                    "Log-in",
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 1.3,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Signup()),
                      );
                    });
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: neutralColor))),
                      backgroundColor: MaterialStatePropertyAll(neutralColor)),
                  child: CustomText(
                    "SignUp",
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
