// import 'package:flutter/material.dart';
// import 'package:pragma_design_system/src/components/templates/ds_home_template.dart';

// /// Página principal del e-commerce.
// ///
// /// Esta página utiliza el template [DSHomeTemplate] y le inyecta la configuración
// /// a través de un mapa, simulando datos reales provenientes de una API o base local.
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late Map<String, dynamic> _homeConfig;

//   @override
//   void initState() {
//     super.initState();

//     // Configuración inicial simulando respuesta de backend o CMS

//     _homeConfig = {
//       "title": "Inicio",
//       "banner": {
//         "imageUrl": "https://picsum.photos/800/300",
//         "title": "Ofertas de la Semana",
//         "subtitle": "Hasta 50% de descuento en electrónicos",
//       },
//       "sections": [
//         {
//           "title": "Recomendados para ti",
//           "grid": true,
//           "products": [
//             {
//               "imageUrl": "https://picsum.photos/200",
//               "title": "Audífonos Bluetooth",
//               "price": "\$120.000",
//             },
//             {
//               "imageUrl": "https://picsum.photos/201",
//               "title": "Smartwatch Deportivo",
//               "price": "\$250.000",
//             },
//           ],
//         },
//         {
//           "title": "Ofertas relámpago",
//           "products": [
//             {
//               "imageUrl": "https://picsum.photos/202",
//               "title": "Cámara 4K",
//               "price": "\$899.000",
//             },
//           ],
//         },
//       ],
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: DSHomeTemplate(config: _homeConfig),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/components/templates/ds_home_template.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Página principal del e-commerce.
///
/// Muestra inicialmente un DSLoader con un pequeño retraso
/// para simular carga de datos (por ejemplo desde API o base local).
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
        backgroundColor: Colors.white,
        body: Center(
          child: DSLoader(
            label: "Loading...",
            color: DSColorsFoundations.brandSecondary,
            size: DSSizesFoundations.imageSizeXL,
          ),
        ),
      );
    }

    return SafeArea(
      child: DSHomeTemplate(
        config: {
          "title": "Inicio",
          "banner": {
            "imageUrl": "https://picsum.photos/800/300",
            "title": "Ofertas de la Semana",
            "subtitle": "Hasta 50% de descuento en electrónicos",
          },
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
