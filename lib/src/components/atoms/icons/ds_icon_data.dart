import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Clase que permite registrar y obtener íconos personalizados (SVG)
/// como si fueran [IconData].
///
/// Esto permite utilizar íconos personalizados dentro de widgets que
/// esperan un IconData, como el átomo DSIcon.
///
/// Ejemplo:
/// ```dart
/// final cartIcon = DSIconData.fromSvg('cart');
/// DSIcon(icon: cartIcon);
/// ```
class DSIconData {
  /// Nombre del archivo SVG sin extensión.
  final String name;

  /// Ruta base donde se almacenan los íconos.
  static const String _basePath = 'assets/icons/svg/';

  const DSIconData(this.name);

  String get path => '$_basePath$name.svg';
  IconData toIconData() {
    final int codePoint = name.hashCode & 0xFFFFF;

    return IconData(
      codePoint,
      fontFamily: 'DSCustomIcons',
      fontPackage: null,
      matchTextDirection: false,
    );
  }

  /// Permite renderizar directamente el SVG correspondiente.
  Widget toSvg({double? size, Color? color}) {
    return SvgPicture.asset(
      path,
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }

  /// Crea un ícono a partir del nombre, retornando directamente un IconData.
  static IconData fromSvg(String name) => DSIconData(name).toIconData();
}
