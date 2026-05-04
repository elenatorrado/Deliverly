import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFF2F00);
  static const Color secondary = Color(0xFFF8928E);
  static const Color white = Colors.white;

  // Degradado (para fondos)
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color.fromARGB(255, 248, 20, 20), Color(0xFFF6B3A8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  // Degradado (para fondos)
  static const LinearGradient backgroundGradientPedidos = LinearGradient(
    colors: [Color(0xFF6183AA), Color(0x00FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
