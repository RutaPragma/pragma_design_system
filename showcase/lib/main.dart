import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/appState/theme_bloc.dart';
import 'package:showcase/appState/theme_state.dart';
import 'package:showcase/views/theme_button.dart';
import 'package:showcase/views/views.dart';

void main() {
  runApp(BlocProvider(create: (context) => ThemeBloc(), child: const MyApp()));
}

class ShowcaseMenu {
  ShowcaseMenu({required this.title, required this.icon, required this.route});
  final String title;
  final IconData icon;
  final MaterialPageRoute route;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<ShowcaseMenu> titleList = [
      ShowcaseMenu(
        title: 'Tokens',
        icon: Icons.token_rounded,
        route: MaterialPageRoute(
          builder: (context) => this,
          fullscreenDialog: false,
        ),
      ),
      ShowcaseMenu(
        title: 'Foundation',
        icon: Icons.foundation_rounded,
        route: MaterialPageRoute(
          builder: (context) => this,
          fullscreenDialog: false,
        ),
      ),
      ShowcaseMenu(
        title: 'Átomos',
        icon: Icons.ac_unit,
        route: MaterialPageRoute(
          builder: (context) => AtomsShowcase(),
          fullscreenDialog: false,
        ),
      ),
      ShowcaseMenu(
        title: 'Moléculas',
        icon: Icons.mobile_friendly_sharp,
        route: MaterialPageRoute(
          builder: (context) => MoleculesShowcase(),
          fullscreenDialog: false,
        ),
      ),
      ShowcaseMenu(
        title: 'Organismos',
        icon: Icons.crop_original_outlined,
        route: MaterialPageRoute(
          builder: (context) => OrganismsShowcase(),
          fullscreenDialog: false,
        ),
      ),
      ShowcaseMenu(
        title: 'Templates',
        icon: Icons.temple_hindu_sharp,
        route: MaterialPageRoute(
          builder: (context) => TemplatesShowcaseMenu(),
          fullscreenDialog: false,
        ),
      ),
      ShowcaseMenu(
        title: 'Páginas',
        icon: Icons.pages,
        route: MaterialPageRoute(
          builder: (context) => this,
          fullscreenDialog: false,
        ),
      ),
    ];

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Pragma Design System',
          debugShowCheckedModeBanner: false,
          theme: state.themeData,

          home: Scaffold(
            appBar: AppBar(
              title: Text('Pragma Design System'),
              actions: [ThemeButton()],
            ),
            body: GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: DSSpacingFoundations.medium,
                vertical: DSSpacingFoundations.medium,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 150,
              ),
              itemCount: titleList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async => await Navigator.of(
                    context,
                  ).push(titleList.elementAt(index).route),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          titleList.elementAt(index).title,
                          style: DSTypographyFoundations.bodyMedium.copyWith(
                            fontSize: DSSizesFoundations.textSizeLarge,
                          ),
                        ),
                        DSIcon(
                          icon: titleList.elementAt(index).icon,
                          size: DSSize.small,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
