import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/views/theme_button.dart';

class AtomsShowcase extends StatelessWidget {
  AtomsShowcase({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa un correo electrónico';
    }

    // Regex simple para validar el formato del correo
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Ingresa un correo válido';
    }

    return null;
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      log('valid');
    }
  }

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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('DSInputField', style: DSTypography.displayLargeBold),
                  const SizedBox(height: 16),
                  DSInputField(
                    hintText: 'Escribe aqui',
                    prefixIcon: DSIcon(
                      icon: Icons.apple,
                      color: DSIconColor.secondary,
                    ),
                  ),
                  DSSepareted(5),
                  DSInputField(
                    hintText: 'Deshabilitado',
                    prefixIcon: DSIcon(
                      icon: Icons.apple,
                      color: DSIconColor.secondary,
                    ),
                    enabled: false,
                  ),
                  DSSepareted(5),
                  DSInputField(
                    label: 'Ingresa tu email',
                    controller: _emailController,
                    suffixIcon: DSIcon(
                      icon: Icons.email,
                      color: DSIconColor.secondary,
                    ),
                    validator: _validateEmail,
                    onChanged: (val) => _submitForm(context),
                  ),
                  DSSepareted(5),
                  DSInputField(
                    label: 'Ingresa tu contraseña',
                    obscureText: true,
                  ),
                  DSSepareted(5),
                  DSInputField(
                    label: 'Area',
                    maxLines: 5,
                    hintText: 'Escribe...',
                  ),
                  DSSepareted(5),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('DSBadge', style: DSTypography.displayLargeBold),
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
                        DSBadge(
                          label: '2',
                          backgroundColor: DSColorsFoundations.error,
                        ),
                        Text('default', style: DSTypography.displayXSNormal),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSBadge(
                          label: 'NEW',
                          backgroundColor: DSColorsFoundations.success,
                          textColor: DSColorsFoundations.textOnPrimary,
                          isCircular: false,
                        ),
                        Text('default', style: DSTypography.displayXSNormal),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSBadge(
                          size: 30,
                          label: 'New',
                          isMedal: true,
                          backgroundColor: DSColorsFoundations.brandSecondary,
                          textColor: DSColorsFoundations.textOnSecondary,
                        ),
                        Text('Size 30', style: DSTypography.displayXSNormal),
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
                Text('DSLoader', style: DSTypography.displayLargeBold),
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
                        DSLoader(
                          size: 55,
                          color: DSColorsFoundations.brandSecondary,
                          duration: Duration(seconds: 3),
                        ),
                        Text('Size 55', style: DSTypography.displayXSNormal),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSLoader(
                          label: 'Cargando',
                          color: const Color.fromARGB(255, 171, 2, 205),
                          size: 80,
                        ),

                        Text('Size 80', style: DSTypography.displayXSNormal),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DSLoader(
                          label: '',
                          color: DSColorsFoundations.successDark,
                          size: 30,
                        ),

                        Text('Size 30', style: DSTypography.displayXSNormal),
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
