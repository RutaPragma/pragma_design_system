import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/views/theme_button.dart';

class AtomsShowcase extends StatelessWidget {
  const AtomsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Átomos'),
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

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('DSIconButton', style: DSTypography.displayLargeBold),
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
                        DSIconButton(
                          icon: Icons.person,
                          size: DSSize.xs,
                          onPressed: () {},
                        ),
                        Text('DSSize.xs', style: DSTypography.displayXSNormal),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSIconButton(
                          icon: Icons.person,
                          size: DSSize.small,
                          onPressed: () {},
                          isCircular: false,
                          variant: DSIconButtonVariant.disabled,
                        ),
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
                        DSIconButton(
                          icon: Icons.person,
                          size: DSSize.medium,
                          onPressed: () {},
                        ),
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
                        DSIconButton(
                          icon: Icons.person,
                          size: DSSize.large,
                          isCircular: false,
                          variant: DSIconButtonVariant.secondary,
                          onPressed: () {},
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
                        DSIconButton(
                          icon: Icons.person,
                          size: DSSize.xl,
                          onPressed: () {},
                          customColor: Colors.pinkAccent,
                        ),
                        Text('DSSize.xl', style: DSTypography.displayXSNormal),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSIconButton(
                          icon: Icons.person,
                          customSize: 70,
                          onPressed: () {},
                          isCircular: false,
                        ),
                        Text(
                          'customSize: 70',
                          style: DSTypography.displayXSNormal,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text('DSButton', style: DSTypography.displayLargeBold),
                const SizedBox(height: 16),
                DSButton(
                  size: DSSize.xs,
                  onPressed: () {},
                  label: 'DSSize.xs',
                  variant: DSButtonVariant.secondary,
                  radius: DSSizeRadius.large,
                ),
                DSSepareted(5),
                DSButton(
                  size: DSSize.small,
                  onPressed: () {},
                  label: 'DSSize.small',
                  variant: DSButtonVariant.disabled,
                ),
                DSSepareted(5),
                DSButton(
                  size: DSSize.medium,
                  onPressed: () {},
                  label: 'DSSize.medium',
                  radius: DSSizeRadius.medium,
                  icon: Icon(Icons.apple, size: 24),
                ),
                DSSepareted(5),
                DSButton(
                  size: DSSize.large,
                  onPressed: () {},
                  label: 'DSSize.large',
                  radius: DSSizeRadius.radiusCircular,
                  icon: Icon(Icons.apple, size: 24),
                  iconDirection: DSButtonIconDirection.rigth,
                  elevation: DSSpacin.medium,
                ),
                DSSepareted(5),
                DSButton(size: DSSize.xl, onPressed: () {}, label: 'DSSize.xl'),
                const SizedBox(height: 40),
              ],
            ),
          ),

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
                        DSFabButton(
                          size: DSSize.xs,
                          onPressed: () {},
                          variant: DSFabVariant.primary,
                          radius: DSSizeRadius.xs,
                          icon: Icons.apple,
                          elevation: DSSpacin.small,
                        ),
                        Text('DSSize.xs', style: DSTypography.displayXSNormal),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSFabButton(
                          size: DSSize.small,
                          onPressed: () {},
                          variant: DSFabVariant.secondary,
                          radius: DSSizeRadius.xs,
                          icon: Icons.apple,
                          elevation: DSSpacin.small,
                        ),
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
                        DSFabButton(
                          size: DSSize.medium,
                          onPressed: () {},
                          variant: DSFabVariant.primary,
                          radius: DSSizeRadius.xs,
                          icon: Icons.apple,
                          elevation: DSSpacin.small,
                        ),
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
                        DSFabButton(
                          size: DSSize.large,
                          onPressed: () {},
                          variant: DSFabVariant.primary,
                          radius: DSSizeRadius.xs,
                          icon: Icons.apple,
                          elevation: DSSpacin.small,
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
                        DSFabButton(
                          size: DSSize.xl,
                          onPressed: () {},
                          variant: DSFabVariant.secondary,
                          radius: DSSizeRadius.xs,
                          icon: Icons.apple,
                          elevation: DSSpacin.small,
                        ),
                        Text('DSSize.xl', style: DSTypography.displayXSNormal),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Column(
          //     children: [
          //       Text('DSFabButton', style: DSTypography.displayLargeBold),
          //       const SizedBox(height: 16),
          //       DSFabButton(
          //         size: DSSize.medium,
          //         onPressed: () {},
          //         variant: DSFabVariant.primary,
          //         radius: DSSizeRadius.xs,
          //         icon: Icons.apple,
          //         elevation: DSSpacin.small,
          //       ),
          //       DSSepareted(5),

          //       const SizedBox(height: 40),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
