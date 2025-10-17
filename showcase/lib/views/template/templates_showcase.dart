import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

class TemplatesShowcase extends StatelessWidget {
  const TemplatesShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return DSHomeTemplate(
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
    );
  }
}
