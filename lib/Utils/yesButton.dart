import 'package:every_day/Utils/customText.dart';
import 'package:flutter/material.dart';

class YesButton extends TextButton {
  YesButton({
    super.key,
    required String title,
    required Color color,
    required VoidCallback onPressed,
}) : super(
    onPressed: onPressed,
    child: CustomText(title,color: color,)
  );
}