import 'dart:async';

import 'package:every_day/Page/addTasks.dart';
import 'package:every_day/Page/profile.dart';
import 'package:every_day/Page/tasks.dart';
import 'package:every_day/Services/firebaseHelper.dart';
import 'package:every_day/Utils/barItem.dart';
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
    streamSubscription.cancel();
    super.dispose();
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    if (member == null) {
      return Loading();
    } else {
      return Scaffold(
          body: showPage(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: mainColor,
            onPressed: () {
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) {
                  return AddTasks();
                }));
              });
            },
            child: const Icon(Icons.add_task),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          bottomNavigationBar:  BottomAppBar(
              shape: const CircularNotchedRectangle(),
              color: mainColor,
              height: height / 13,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [

                  BarItem(
                      icon: const Icon(
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
                      icon: const Icon(Icons.supervisor_account, color: Colors.white),
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
        return Profile(
          memberUid: widget.memberUid,
        );
    }
  }
}
