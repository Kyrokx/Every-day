import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:every_day/Utils/customText.dart';
import 'package:every_day/Utils/loading.dart';
import 'package:every_day/Widgets/tasksView.dart';
import 'package:every_day/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Services/firebaseHelper.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<StatefulWidget> createState() {
    return TasksState();
  }
}

class TasksState extends State<Tasks> {

  static final firestroreInstance = FirebaseFirestore.instance;
  final stream = firestroreInstance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection("tasks").snapshots();

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          final userSnapshot = snapshot.data!.docs;
          if (userSnapshot.isEmpty) {
            return Center(
              child: CustomText("No tasks yet",fontSize: 30.0,),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: CustomText("Task Manager", fontSize: 30.0,),
              centerTitle: true,
              backgroundColor: neutralColor,
            ),



            body: ListView.builder(
                itemCount: userSnapshot.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) {
                              return TasksView(title: userSnapshot[index]["name"], description:  userSnapshot[index]["description"],hour:  userSnapshot[index]["date_created"],taskUid: userSnapshot[index]["task_uid"],date_finish_before:userSnapshot[index]["date_finish_before"]);
                            }));
                          });
                        },
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor: Colors.grey,
                                icon: Icons.cancel_outlined,
                                label: "Cancel",
                                onPressed: (context) {},
                              ),

                              SlidableAction(
                                backgroundColor: Colors.red,
                                icon: Icons.delete_outline,
                                label: "Delete",
                                onPressed: (context) {
                                  setState(() {
                                    FirebaseHelper().deleteTask(userSnapshot[index]["task_uid"]);
                                  });
                                },
                              ),
                            ],
                          ),
                          child: ListTile(
                              title: CustomText("Title : ${userSnapshot[index]["name"]}",textAlign: TextAlign.start,),
                              subtitle: CustomText("Description : ${userSnapshot[index]["description"]}", textAlign: TextAlign.end,),
                              contentPadding: const EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: mainColor),
                              )
                          ),
                        ),
                      )
                  );
                }),
          );
        });
  }
}