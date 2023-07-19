import 'package:every_day/constant.dart';
import 'package:flutter/material.dart';

class BarItem extends IconButton {
  BarItem({
    required Icon icon,
    required VoidCallback onPressed,
    required bool selected
  }) : super(
      icon: icon,
      onPressed: onPressed,
      color: selected ? mainColor : secondColor
  );
}