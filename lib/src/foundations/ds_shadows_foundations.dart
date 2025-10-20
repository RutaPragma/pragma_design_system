import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/tokens/ds_shadows.dart';

/// Fundaciones de sombras para el sistema de diseño.
/// Organiza las sombras base por propósito y contexto de uso.
class DSShadowsFoundations {
  DSShadowsFoundations._();

  static const List<BoxShadow> shadowSmall = DSShadows.shadowSmall;
  static const List<BoxShadow> shadowMedium = DSShadows.shadowMedium;
  static const List<BoxShadow> shadowLarge = DSShadows.shadowLarge;
  static const List<BoxShadow> shadowAppshadowXSBar = DSShadows.shadowXS;
  static const List<BoxShadow> shadowXL = DSShadows.shadowXL;
  static const List<BoxShadow> shadowDisabled = DSShadows.shadowDisabled;
  static const List<BoxShadow> defaultShadow = DSShadows.shadowSmall;
}
