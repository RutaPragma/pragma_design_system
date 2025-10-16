import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/views/theme_button.dart';

class OrganismsShowcase extends StatefulWidget {
  const OrganismsShowcase({super.key});

  @override
  State<OrganismsShowcase> createState() => _OrganismsShowcaseState();
}

class _OrganismsShowcaseState extends State<OrganismsShowcase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organismos'),
        centerTitle: true,
        actions: [ThemeButton()],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              children: [
                Text('DSProductList', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                DSProductList(
                  isGrid: true,
                  crossAxisCount: 2,
                  showAddButton: true,
                  showMenuChange: true,
                  spacing: DSSizesFoundations.separatorMedium,
                  onProductTap: (product) => print(product.title),
                  products: [
                    ProductItem(
                      imageUrl:
                          "https://nikeco.vtexassets.com/arquivos/ids/808959-500-500?v=638807696434500000",
                      title: "Zapatos Nike Air",
                      price: "\$299.000",
                      rating: 4.5,
                      badgeText: "Nuevo",
                    ),
                    ProductItem(
                      imageUrl:
                          "https://nikeco.vtexassets.com/arquivos/ids/607564-500-500?v=638549212427500000",
                      title: "Camisa Polo",
                      price: "\$159.900",
                      rating: 4.2,
                      // badgeText: "Oferta",
                    ),
                    ProductItem(
                      imageUrl:
                          "https://nikeco.vtexassets.com/arquivos/ids/846904-500-500?v=638815508479530000",
                      title: "Camisa Polo",
                      price: "\$159.900",
                      rating: 4.2,
                      // badgeText: "Oferta",
                    ),
                    ProductItem(
                      imageUrl:
                          "https://nikeco.vtexassets.com/arquivos/ids/734189-500-500?v=638708427069200000",
                      title: "Air Zoom Pegasus 41",
                      price: "\$159.900",
                      rating: 4.2,
                      // badgeText: "Oferta",
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
