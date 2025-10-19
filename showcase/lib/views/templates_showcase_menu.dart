import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/views/theme_button.dart';

class TemplatesShowcaseMenu extends StatelessWidget {
  TemplatesShowcaseMenu({super.key});

  final List<Map<String, dynamic>> items = [
    {
      "title": "DSHomeTemplate",
      "config": {
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
    },
    {
      "title": "DSProductDetailPage",
      "config": {
        "appBarTitle": "Detalle del producto",
        "accentColor": DSColorsFoundations.brandPrimary,
        "grid": true,
        "product": {
          "imageUrl":
              "https://nikeco.vtexassets.com/arquivos/ids/806707-1200-auto?v=638836101621400000&width=1200&height=auto&aspect=true",
          "title": "Zapatillas Urban X",
          "price": "\$250.000",
          "description":
              "Comodidad y estilo con las Zapatillas Urban X, perfectas para tu día a día.",
          "rating": 4.5,
          "badgeText": "Top Ventas",
        },

        /// * ver banner
        /*"promoBanner": {
          "title": "Ofertas exclusivas 🔥",
          "subtitle": "Aprovecha hasta 40% de descuento solo por hoy",
          "imageUrl":
              "https://nikeco.vtexassets.com/arquivos/ids/809858-1200-auto?v=638807698968530000",
          "badgeText": "Nuevo",
          // "buttonLabel": "Ver ofertas",
          "backgroundColor": DSColorsFoundations.brandSecondary,
          "textColor": Colors.black,
          "isReversed": true,
          "size": 200.0,
          "onPressed": () => print("Ver ofertas"),
        },*/
        "onAddToCart": () => print("Agregado al carrito"),
        "onBuyNow": () => print("Comprar ahora"),
        "relatedTitle": "También te puede gustar",
        "relatedProducts": [
          {
            "imageUrl":
                "https://nikeco.vtexassets.com/arquivos/ids/893589-1200-auto?v=638896609278930000&width=1200&height=auto&aspect=true",
            "title": "Zapatillas Sport Runner",
            "price": "\$200.000",
            "badgeText": "Nuevo",
          },
          {
            "imageUrl":
                "https://nikeco.vtexassets.com/arquivos/ids/884347-1200-auto?v=638883567117600000&width=1200&height=auto&aspect=true",
            "title": "Zapatillas Urban Classic",
            "price": "\$230.000",
          },
        ],
      },
    },
    {"title": "", "config": {}},
  ];

  Widget getWidget(String widget, dynamic config) {
    switch (widget) {
      case 'DSHomeTemplate':
        return DSHomeTemplate(config: config);
      case 'DSProductDetailPage':
        return DSProductDetailPage(config: config);
      default:
        return DSProductDetailPage(config: config);
    }
  }

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
            title: Text(items[index]['title']),
            trailing: Icon(Icons.arrow_circle_right_outlined),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    getWidget(items[index]['title'], items[index]['config']),
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
