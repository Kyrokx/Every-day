import 'package:every_day/Services/firebaseHelper.dart';
import 'package:every_day/Utils/custonText.dart';
import 'package:every_day/Utils/showPopUp.dart';
import 'package:every_day/constant.dart';
import 'package:flutter/material.dart';

class AddTasks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AddTasksState();
  }
}


class AddTasksState extends State<AddTasks> {
  late TextEditingController name_controller = TextEditingController();
  late TextEditingController description_controller = TextEditingController();

  late FocusNode name_focus;
  late FocusNode description_focus;


  @override
  void initState() {
    super.initState();
    name_controller = TextEditingController();
    description_controller = TextEditingController();
    name_focus = FocusNode();
    description_focus = FocusNode();
  }


  @override
  void dispose() {
    super.dispose();
    name_controller.dispose();
    description_controller.dispose();
    name_focus.dispose();
    description_focus.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText('Add your task here !',fontSize: 25.0,),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: mainColor)),
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  controller: name_controller,
                  focusNode: name_focus,
                  decoration: InputDecoration(
                    hintText: "Wash dishes",
                    label: CustomText("Enter a name", color: Colors.black,),
                    icon: const Icon(Icons.my_library_books,),
                  ),
                ),
              ),


              Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: mainColor)),
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextField(
                  textInputAction: TextInputAction.done,
                  controller: description_controller,
                  focusNode: description_focus,
                  decoration: InputDecoration(
                    hintText: "Very important",
                    label: CustomText("Enter a description", color: Colors.black,),
                    icon: const Icon(Icons.description,),
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
                      MaterialStatePropertyAll(secondColor)),
                  child: CustomText(
                    "Add",
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),

            ],
          ),
        ),
    );
  }

  check() {
    if (name_controller.text.isNotEmpty &
    description_controller.text.isNotEmpty) {

      setState(() {
        FirebaseHelper().addTask(name_controller.text, description_controller.text);
        Navigator.pop(context);
        ShowPopUp().taskAdded(context);
      });

    } else {
      ShowPopUp().errorPopUp(context, "Please , enter all informations !");
    }
  }

}