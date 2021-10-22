import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle(
    {Color color = Colors.black,
    double opacity = 0.85,
    double size = 18,
    FontWeight fontWeight = FontWeight.w500}) {
  return GoogleFonts.notoSans(
    color: color.withOpacity(opacity),
    fontWeight: fontWeight,
    fontSize: size,
  );
}
