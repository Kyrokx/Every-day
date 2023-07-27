import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:every_day/Services/firebaseHelper.dart';
import 'package:every_day/Utils/custonText.dart';
import 'package:every_day/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TasksView extends StatefulWidget {

  late String title;
  late String description;
  late Timestamp hour;
  late String taskUid;
  late Timestamp date_finish_before;

  TasksView({required this.title,required this.description, required this.hour, required this.taskUid, required this.date_finish_before});
  @override
  State<StatefulWidget> createState() {
    return new TasksViewState();
  }
}

class TasksViewState extends State<TasksView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      //appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /*SizedBox(
              child: Image.asset("assets/presse-papiers.png", fit: BoxFit.cover,),
              height: MediaQuery.of(context).size.height * 0.2,
            ),*/
            CustomText("Title : ${widget.title}",fontSize: 30.0,),
            CustomText("Description : ${widget.description}",fontSize: 30.0,),
            CustomText("Date created : ${DateFormat.yMd().add_Hm().format(widget.hour.toDate()).toString()}",fontSize: 30.0,),
            CustomText("You have to finish it before : ${DateFormat.yMd().format(widget.date_finish_before.toDate()).toString()}",fontSize: 30.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        FirebaseHelper().deleteTask(widget.taskUid);
                        Navigator.pop(context);
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
                        MaterialStatePropertyAll(Colors.green)),
                    child: CustomText(
                      "Valid",
                      fontSize: 30.0,
                      color: Colors.black,
                    ),
                  ),
                ),


                /*Container(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 3.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: BorderSide(color: Colors.red))),
                        backgroundColor:
                        MaterialStatePropertyAll(Colors.red)),
                    child: CustomText(
                      "Delete",
                      fontSize: 30.0,
                      color: Colors.black,
                    ),
                  ),
                ),*/

              ],
            )
          ],
        ),
      ),
    );
  }
}