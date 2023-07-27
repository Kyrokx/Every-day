import 'dart:async';

import 'package:every_day/Models/member.dart';
import 'package:every_day/Services/firebaseHelper.dart';
import 'package:every_day/Utils/custonText.dart';
import 'package:every_day/Utils/loading.dart';
import 'package:every_day/Utils/showPopUp.dart';
import 'package:every_day/constant.dart';
import 'package:flutter/material.dart';

class Profil extends StatefulWidget {

  late String memberUid;

  Profil({super.key, required this.memberUid});

  @override
  State<StatefulWidget> createState() {



    return ProfilState();
  }
}

class ProfilState extends State<Profil> {

  late StreamSubscription streamSubscription;
  Member? member;

  @override
  void initState() {
    super.initState();
    streamSubscription = FirebaseHelper()
        .fire_user
        .doc(widget.memberUid)
        .snapshots()
        .listen((event) {
      setState(() {
        member = Member(event);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamSubscription.cancel();
  }

  @override
  int x = 0;

  Widget build(BuildContext context) {
    if(member == null) {
      return Loading();
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(10.0),
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
                    ShowPopUp().changeUsername(context, member!);
                  });
                },
              ),

              ListTile(
                title: CustomText("Log out",fontSize: 25.0,),
                leading: Icon(Icons.logout,color: easterEgg(),),
                onTap: () {
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
                  }

              ),

              /*ListTile(
                  title: CustomText("Delete Account",fontSize: 25.0,),
                  leading: Icon(Icons.delete_forever_outlined,color: easterEgg(),),
                  onTap: () {
                    setState(() {
                      ShowPopUp().deleteAcount(context);
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
                  }
              ),*/

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