import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends Text {
  CustomText(String data, {super.key, color: Colors.black, textAlign = TextAlign.center, fontSize = 15.0, fontStyle = FontStyle.normal})
      : super(
    data = data,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontStyle: fontStyle,
        fontSize: fontSize,
        fontFamily: GoogleFonts.quicksand().fontFamily
    ),

  );
}
