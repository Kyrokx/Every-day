import 'package:every_day/Utils/customText.dart';
import 'package:every_day/constant.dart';
import 'package:flutter/material.dart'
    '';
class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularProgressIndicator(color: mainColor,),
            CustomText("Loading...")
          ],
        ),
      ),
    );
  }
}