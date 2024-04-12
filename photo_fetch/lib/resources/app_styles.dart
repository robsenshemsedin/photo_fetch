import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_fetch/resources/resources.dart';

class AppStyles {
  static TextStyle appTitleStyle = GoogleFonts.tiltNeon(
      fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 25);

  static TextStyle photoTitleTextStyle = GoogleFonts.roboto(
    letterSpacing: 0.2,
    wordSpacing: 2,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static InputDecoration textFieldDecoration = InputDecoration(
    hintMaxLines: 1,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
          BorderRadiusSizes.lg), // Adjust the radius for desired curvature
    ),
  );
}
