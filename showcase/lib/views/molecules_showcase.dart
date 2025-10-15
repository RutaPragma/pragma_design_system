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
                Text('DSIcon', style: DSTypography.displayLargeBold),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSIcon(icon: Icons.person, size: DSSize.xs),
                        Text('DSSize.xs', style: DSTypography.displayXSNormal),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSIcon(icon: Icons.person, size: DSSize.small),
                        Text(
                          'DSSize.small',
                          style: DSTypography.displayXSNormal,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSIcon(icon: Icons.person, size: DSSize.medium),
                        Text(
                          'DSSize.medium',
                          style: DSTypography.displayXSNormal,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSIcon(
                          icon: Icons.person,
                          size: DSSize.large,
                          color: DSIconColor.disabled,
                        ),
                        Text(
                          'DSSize.large',
                          style: DSTypography.displayXSNormal,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSIcon(
                          icon: Icons.person,
                          size: DSSize.xl,
                          color: DSIconColor.secondary,
                        ),
                        Text('DSSize.xl', style: DSTypography.displayXSNormal),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSIcon(
                          icon: Icons.person,
                          customSize: 64,
                          customColor: Colors.blue,
                        ),
                        Text(
                          'customSize: 64',
                          style: DSTypography.displayXSNormal,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
