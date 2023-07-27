import 'dart:async';

import 'package:every_day/Page/addTasks.dart';
import 'package:every_day/Page/profil.dart';
import 'package:every_day/Page/tasks.dart';
import 'package:every_day/Services/firebaseHelper.dart';
import 'package:every_day/Utils/barItem.dart';
import 'package:every_day/Utils/cached_manager.dart';
import 'package:every_day/Utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:every_day/constant.dart';

import '../Models/member.dart';

class Home extends StatefulWidget {
  late String memberUid;
  Home({super.key, required this.memberUid});
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
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
    super.dispose();
    streamSubscription.cancel();
  }

  @override
  int index = 0;

  Widget build(BuildContext context) {
    if (member == null) {
      return Loading();
    } else {
      return Scaffold(
          body: showPage(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_task),
            backgroundColor: mainColor,
            onPressed: () {
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) {
                  return AddTasks();
                }));
              });
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          bottomNavigationBar:  BottomAppBar(
              shape: const CircularNotchedRectangle(),
              color: mainColor,
              height: MediaQuery.of(context).size.height / 13,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [

                  BarItem(
                      icon: Icon(
                        Icons.task,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          buttonSelected(0);
                        });
                      },
                      selected: (index == 0)),
                  BarItem(
                      icon: Icon(Icons.supervisor_account, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          buttonSelected(1);
                        });
                      },
                      selected: (index == 1)
                  ),
                ],
              ),
            )
      );
    }
  }

  buttonSelected(int index) {
    setState(() {
      this.index = index;
    });
  }

  showPage() {
    switch (index) {
      case 0:
        return Tasks();
      case 1:
        return Profil(
          memberUid: widget.memberUid,
        );
    }
  }
}
