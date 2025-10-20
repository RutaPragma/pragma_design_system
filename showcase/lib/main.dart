import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/appState/theme_bloc.dart';
import 'package:showcase/appState/theme_state.dart';
import 'package:showcase/views/views.dart';
import 'package:showcase/views/home.dart';

void main() {
  runApp(BlocProvider(create: (context) => ThemeBloc(), child: const MyApp()));
}

class ShowcaseMenu {
  ShowcaseMenu({
    required this.title,
    required this.icon,
    required this.routeName,
    required this.builder,
  });
  final String title;
  final IconData icon;
  final String routeName;
  final Widget Function(BuildContext) builder;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final List<ShowcaseMenu> menuItems = [
    ShowcaseMenu(
      title: 'Tokens',
      icon: Icons.token_rounded,
      routeName: '/tokens',
      builder: (context) => const DSTokensShowcase(),
    ),
    ShowcaseMenu(
      title: 'Foundation',
      icon: Icons.foundation_rounded,
      routeName: '/foundations',
      builder: (context) => const DSFoundationsShowcase(),
    ),
    ShowcaseMenu(
      title: 'Átomos',
      icon: Icons.ac_unit,
      routeName: '/atoms',
      builder: (context) => const AtomsShowcase(),
    ),
    ShowcaseMenu(
      title: 'Moléculas',
      icon: Icons.mobile_friendly_sharp,
      routeName: '/molecules',
      builder: (context) => const MoleculesShowcase(),
    ),
    ShowcaseMenu(
      title: 'Organismos',
      icon: Icons.crop_original_outlined,
      routeName: '/organisms',
      builder: (context) => const OrganismsShowcase(),
    ),
    ShowcaseMenu(
      title: 'Templates',
      icon: Icons.temple_hindu_sharp,
      routeName: '/templates',
      builder: (context) => TemplatesShowcaseMenu(),
    ),
    ShowcaseMenu(
      title: 'Páginas',
      icon: Icons.pages,
      routeName: '/pages',
      builder: (context) => const HomePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Pragma Design System',
          debugShowCheckedModeBanner: false,
          theme: state.themeData,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            if (settings.name == '/') {
              return MaterialPageRoute(
                builder: (context) => const Home(),
                settings: settings,
              );
            }

            final menuItem = menuItems.firstWhere(
              (element) => element.routeName == settings.name,
              orElse: () => menuItems.first,
            );

            return MaterialPageRoute(
              builder: menuItem.builder,
              settings: settings,
            );
          },
          home: const Home(),
        );
      },
    );
  }
}
