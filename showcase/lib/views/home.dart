import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/main.dart';
import 'package:showcase/views/theme_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pragma Design System'),
        actions: const [ThemeButton()],
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
        itemCount: MyApp.menuItems.length,
        itemBuilder: (context, index) {
          final menuItem = MyApp.menuItems[index];
          return InkWell(
            onTap: () => Navigator.of(context).pushNamed(menuItem.routeName),
            child: Card(
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    menuItem.title,
                    style: DSTypographyFoundations.bodyMedium.copyWith(
                      fontSize: DSSizesFoundations.textSizeLarge,
                    ),
                  ),
                  Icon(menuItem.icon, size: DSSizesFoundations.iconSizeSmall),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
