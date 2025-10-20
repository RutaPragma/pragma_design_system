import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/ds_sizes_foundations.dart';

/// Átomo de separación vertical para layouts.
///
/// Este componente permite agregar espacio vertical entre widgets, usando la escala de separación definida en foundations.
///
/// Ejemplo de uso:
/// ```dart
/// Column(
///   children: [
///     Text('Elemento 1'),
///     DSSepareted(2),
///     Text('Elemento 2'),
///   ],
/// )
/// ```
class DSSepareted extends StatelessWidget {
  const DSSepareted(this.separated, {super.key});

  final double separated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: separated * DSSizesFoundations.separatorSmall);
  }
}
