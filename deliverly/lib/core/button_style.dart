import 'package:deliverly/core/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonStyles {
  static final ButtonStyle boton = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(AppColors.primary),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
    ),
  );
}
