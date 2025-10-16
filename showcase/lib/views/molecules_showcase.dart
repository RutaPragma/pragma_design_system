import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/views/theme_button.dart';

class MoleculesShowcase extends StatelessWidget {
  const MoleculesShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moléculas'),
        centerTitle: true,
        actions: [ThemeButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('DSSearchBar', style: DSTypography.displayLargeBold),

                DSSearchBar(
                  hintText: "Buscar productos...",
                  onChanged: (value) => print("Buscando: $value"),
                  onClear: () => print("Limpió búsqueda"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
