import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/views/theme_button.dart';

class TemplatesShowcaseMenu extends StatelessWidget {
  TemplatesShowcaseMenu({super.key});
  final items = [
    [
      'DSHomeTemplate',
      {
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
    ],
    ['Otro', {}],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates'),
        centerTitle: true,
        actions: [ThemeButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            title: Text(items[index][0].toString()),
            trailing: Icon(Icons.arrow_circle_right_outlined),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DSHomeTemplate(
                  config: items[index][1] as Map<String, dynamic>,
                ),
              ),
            ),
          ),
          separatorBuilder: (_, __) => Divider(),
          itemCount: items.length,
        ),
      ),
    );
  }
}
