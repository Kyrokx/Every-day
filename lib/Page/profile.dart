import 'dart:async';

import 'package:every_day/Models/member.dart';
import 'package:every_day/Services/firebaseHelper.dart';
import 'package:every_day/Utils/customText.dart';
import 'package:every_day/Utils/loading.dart';
import 'package:every_day/Utils/showPopUp.dart';
import 'package:every_day/constant.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {

  late String memberUid;

  Profile({super.key, required this.memberUid});

  @override
  State<StatefulWidget> createState() {

    return ProfileState();
  }
}

class ProfileState extends State<Profile> {

  late StreamSubscription streamSubscription;
  Member? member;
  late TextEditingController newUserName_controller;

  @override
  void initState() {
    newUserName_controller = TextEditingController();
    streamSubscription = FirebaseHelper()
        .fire_user
        .doc(widget.memberUid)
        .snapshots()
        .listen((event) {
      setState(() {
        member = Member(event);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    newUserName_controller.dispose();
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  int x = 0;

  @override
  Widget build(BuildContext context) {
    if(member == null) {
      return Loading();
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Card(
                elevation: 10.0,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10.0),
                  leading: Icon(Icons.account_box,color: easterEgg(),),
                  title: CustomText("Username : ${member!.username}",fontSize: 25.0,textAlign: TextAlign.start,),
                  subtitle: CustomText("Email : ${member!.email}",fontSize: 19.0,textAlign: TextAlign.end,),
                  onLongPress: () {
                    setState(() {
                      if(x < 3) {
                        x++;
                      } else {
                        x = 0;
                      }
                    });
                  },
                  onTap: () {
                    setState(() {
                      ShowPopUp().changeUsername(context, member!,newUserName_controller);
                    });
                  },
                ),
              ),

              TextButton(
                  onPressed: (){
                    setState(() {
                      ShowPopUp().logOut(context);
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      if(x < 3) {
                        x++;
                      } else {
                        x = 0;
                      }
                    });
                  },
                  child: CustomText("Log out",fontSize: 25.0)
              ),

            ],
          )
        ),
      );
    }
  }

  Color? easterEgg(){
      if(x == 0 ) {
        return mainColor;
      } else if (x == 1){
        return Colors.red;
      }else if (x == 2){
        return Colors.blue;
      }else if (x == 3){
        return Colors.green;
      }

  }

}