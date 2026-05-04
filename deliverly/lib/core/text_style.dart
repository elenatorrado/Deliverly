import 'package:deliverly/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static final TextStyle title = GoogleFonts.nunito(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle body = GoogleFonts.roboto(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static final TextStyle label = GoogleFonts.roboto(
    color: const Color(0xFFF0F0F0),
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle bodytextbtn = GoogleFonts.roboto(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static final TextStyle txtAppBar = GoogleFonts.roboto(
    color: Colors.white,
    fontSize: 25,
    fontWeight: FontWeight.normal,
  );
  static final TextStyle titulosCard = GoogleFonts.roboto(
    color: AppColors.primary,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}
