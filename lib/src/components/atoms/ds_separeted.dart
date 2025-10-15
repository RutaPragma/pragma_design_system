import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/foundations/ds_sizes_foundations.dart';

class DSSepareted extends StatelessWidget {
  const DSSepareted(this.separated, {super.key});

  final double separated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: separated * DSSizesFoundations.separatorSmall);
  }
}
