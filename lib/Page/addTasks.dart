import 'package:every_day/Services/firebaseHelper.dart';
import 'package:every_day/Utils/custonText.dart';
import 'package:every_day/Utils/showPopUp.dart';
import 'package:every_day/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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


  String date_before = "";
  late DateTime dateTime_before;

  @override
  Widget build(BuildContext context) {



    return GestureDetector(
        onTap: () {
      setState(() {
        FocusScope.of(context).unfocus();
      });
    },
      child: Scaffold(
        /*appBar: AppBar(
        title: CustomText('Add your task here !',fontSize: 25.0,),
        centerTitle: true,
        backgroundColor: mainColor,
      ),*/
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding:
                const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  controller: name_controller,
                  focusNode: name_focus,
                  cursorColor: mainColor,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                      BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    label: CustomText(
                      "Enter the task's name",
                      color: Colors.grey,
                    ),
                    icon: const Icon(
                      Icons.my_library_books,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),

              Container(
                padding:
                const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  controller: description_controller,
                  focusNode: description_focus,
                  cursorColor: mainColor,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                      BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    label: CustomText(
                      "Enter the task's description",
                      color: Colors.grey,
                    ),
                    icon: const Icon(
                      Icons.description,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),


              CustomText("Finish before : ${date_before}"),

              OutlinedButton(
                onPressed: () {
                  setState(() {
                    datePicker();
                  });
                },
                child: CustomText('Open Date Picker'),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 1.3,
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
                              borderRadius:
                              BorderRadius.circular(10.0),
                              side: BorderSide(color: mainColor))),
                      backgroundColor:
                      MaterialStatePropertyAll(mainColor)),
                  child: CustomText(
                    "Create",
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),



            ],
          ),
        ),
      ),
    );


  }

  check() {
    if (name_controller.text.isNotEmpty ||
    name_controller.text != " ") {
      if(date_before.isNotEmpty || date_before != "") {
        setState(() {
          FirebaseHelper().addTask(name_controller.text, (description_controller.text.isNotEmpty || description_controller.text != " ") ? description_controller.text : "No description set", dateTime_before);
          Navigator.pop(context);
          ShowPopUp().taskAdded(context);
        });
      } else {
        ShowPopUp().errorPopUp(context, "Please, enter a date !");
      }


    } else {
      ShowPopUp().errorPopUp(context, "Please, enter all the information !");
    }
  }


  Future datePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),//DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 2),
        initialDate: DateTime.now()
    );

    if (pickedDate != null ) {
      setState(() {
        date_before = DateFormat.yMd().format(pickedDate!).toString();
        dateTime_before = pickedDate;
      });
    } else {
      return null;
    }

    //return pickedDate;

    /*var x = await DateFormat.yMd().add_Hm().format(pickedDate!);
    return x;*/

  }

}