import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/appState/theme_bloc.dart';
import 'package:showcase/appState/theme_event.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeBloc>().state.isDarkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DSSpacingFoundations.xxs),
      child: DSIconButton(
        icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
        size: DSSize.small,
        onPressed: () {
          context.read<ThemeBloc>().add(ToggleThemeEvent());
        },
      ),
    );
  }
}
