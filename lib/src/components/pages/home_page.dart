import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/components/templates/ds_home_template.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Página principal del e-commerce.
///
/// Muestra inicialmente un DSLoader con un pequeño retraso
/// para simular carga de datos (por ejemplo desde API o base local).
///
/// Ejemplo de uso:
/// ```dart
/// MaterialApp(
///   home: HomePage(),
/// )
/// ```
///
/// Esta página utiliza el template [DSHomeTemplate] y le inyecta la configuración
/// a través de un mapa, simulando datos reales provenientes de una API o base local.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simula la carga inicial de datos
    Timer(const Duration(seconds: 1), () {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        key: ValueKey("homePageLoadingScaffold"),
        backgroundColor: Colors.white,
        body: Center(
          key: ValueKey("homePageLoadingCenter"),
          child: DSLoader(
            key: ValueKey("homePageLoader"),
            label: "Loading...",
            color: DSColorsFoundations.brandSecondary,
            size: DSSizesFoundations.imageSizeXL,
          ),
        ),
      );
    }

    return SafeArea(
      key: const ValueKey("homePageSafeArea"),
      child: DSHomeTemplate(
        key: const ValueKey("homePageTemplate"),
        selectIndex: 0,
        onNavItemSelect: (_) {},
        onAddPressed: (_) {},
        onTapPressed: (_) {},
        onSearch: (_) {},

        config: {
          "title": "Inicio",
          "banner": {
            "imageUrl": "https://picsum.photos/800/300",
            "title": "Ofertas de la Semana",
            "subtitle": "Hasta 50% de descuento en electrónicos",
          },
          "emptyImagePath": "assets/images/illustraction/empty.png",
          "sections": [
            {
              "title": "Recomendados para ti",
              "grid": true,
              "products": [
                {
                  "imageUrl": "https://picsum.photos/200",
                  "title": "Audífonos Bluetooth",
                  "price": "\$120.000",
                },
                {
                  "imageUrl": "https://picsum.photos/201",
                  "title": "Smartwatch Deportivo",
                  "price": "\$250.000",
                },
              ],
            },
            {
              "title": "Ofertas relámpago",
              "products": [
                {
                  "imageUrl": "https://picsum.photos/202",
                  "title": "Cámara 4K",
                  "price": "\$899.000",
                },
              ],
            },
          ],
        },
      ),
    );
  }
}
