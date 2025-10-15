// lib/src/tokens/ds_shadows.dart
import 'package:flutter/material.dart';

class DSShadows {
  DSShadows._();

  /// Sombras básicas reutilizables
  static const List<BoxShadow> shadowXS = [
    BoxShadow(
      color: Color(0x14000000), // 8% opacity black
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadowSmall = [
    BoxShadow(
      color: Color(0x26000000), // 15% opacity black
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadowMedium = [
    BoxShadow(
      color: Color(0x33000000), // 20% opacity black
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadowLarge = [
    BoxShadow(
      color: Color(0x40000000), // 25% opacity black
      offset: Offset(0, 6),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> shadowXL = [
    BoxShadow(
      color: Color(0x4D000000), // 30% opacity black
      offset: Offset(0, 10),
      blurRadius: 20,
      spreadRadius: 0,
    ),
  ];

  /// Sombra para elementos deshabilitados o en fondo gris
  static const List<BoxShadow> shadowDisabled = [
    BoxShadow(
      color: Color(0x1A000000), // 10% opacity black
      offset: Offset(0, 1),
      blurRadius: 1,
      spreadRadius: 0,
    ),
  ];
}