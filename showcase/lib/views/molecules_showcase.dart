import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/views/theme_button.dart';

class MoleculesShowcase extends StatelessWidget {
  const MoleculesShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moléculas'),
        centerTitle: true,
        actions: [ThemeButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('DSSearchBar', style: DSTypography.displayLargeBold),

                DSSearchBar(
                  hintText: "Buscar productos...",
                  onChanged: (value) => log("Buscando: $value"),
                  onClear: () => log("Limpió búsqueda"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('DSProductCard', style: DSTypography.displayLargeBold),

                DSProductCard(
                  imageUrl:
                      'https://nikeco.vtexassets.com/arquivos/ids/733899-1200-auto?v=638708426829470000&width=1200&height=auto&aspect=true',
                  title: 'Tenis deportivos Nike',
                  price: '\$249.900',
                  badgeText: 'New',
                  badgeBackgroundColor: Colors.redAccent,
                  badgeTextColor: Colors.white,
                  badgeSize: 12,
                  bgColor: Colors.deepPurpleAccent,
                  textColor: Colors.yellowAccent,
                  priceColor: Colors.greenAccent,
                  buttonLabel: 'Comprar',
                  btnBackgroundColor: Colors.black,
                  btnTextColor: Colors.greenAccent,
                  onPressed: () => log('Producto agregado'),
                  cardSize: 60,
                ),
                DSSepareted(5),
                DSProductCard(
                  imageUrl:
                      'https://nikeco.vtexassets.com/arquivos/ids/677932/FD6034_001_A_PREM.jpg?v=638623623839300000',
                  title: "Zapatillas deportivas Nike Air",
                  price: "\$120.000",
                  badgeText: "New",
                  isMedal: false,
                  onPressed: () {
                    log("Producto agregado al carrito");
                  },
                  cardSize: 80,
                ),
                DSSepareted(5),
                DSProductCard(
                  imageUrl:
                      'https://nikeco.vtexassets.com/arquivos/ids/677932/FD6034_001_A_PREM.jpg?v=638623623839300000',
                  title: "Zapatillas deportivas Nike Air",
                  price: "\$120.000",
                  badgeText: "New",
                  onPressed: () {
                    log("Producto agregado al carrito");
                  },
                  cardSize: 120,
                ),
                DSSepareted(5),
                DSProductCard(
                  imageUrl:
                      'https://nikeco.vtexassets.com/arquivos/ids/733899-1200-auto?v=638708426829470000&width=1200&height=auto&aspect=true',
                  title: 'Tenis deportivos Nike',
                  price: '\$249.900',
                  badgeText: 'Oferta',
                  badgeBackgroundColor: Colors.redAccent,
                  badgeTextColor: Colors.white,
                  badgeSize: 35,
                  bgColor: Colors.deepPurpleAccent,
                  textColor: Colors.yellowAccent,
                  priceColor: Colors.greenAccent,
                  isMedal: false,
                  buttonLabel: 'Comprar',
                  btnBackgroundColor: Colors.black,
                  btnTextColor: Colors.greenAccent,
                  onPressed: () => log('Producto agregado'),
                  cardSize: 180,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('DSIconCounter', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DSIconCounter(
                      icon: Icons.shopping_cart_outlined,
                      count: 3,
                      badgeTextSize: 10,
                      onTap: () => print("Ir al carrito"),
                    ),

                    DSIconCounter(
                      icon: Icons.notifications_none_rounded,
                      count: 12,
                      badgeBackgroundColor: Colors.redAccent,
                      isMedal: false,
                      badgeTextColor: Colors.white,
                      iconColor: Colors.black,
                    ),
                    DSIconCounter(
                      icon: Icons.notifications_none_rounded,
                      count: 100,
                      badgeBackgroundColor: DSColorsFoundations.brandSecondary,
                      isMedal: true,
                      badgeSize: 14,
                      badgeTextSize: 7,
                      badgeTextColor: Colors.white,
                      iconColor: Colors.black,
                    ),

                    DSIconCounter(
                      icon: Icons.favorite_border_rounded,
                      showBadge: false,
                    ),
                  ],
                ),
                DSSepareted(5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
