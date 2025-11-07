import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/views/theme_button.dart';

class MoleculesShowcase extends StatefulWidget {
  const MoleculesShowcase({super.key});

  @override
  State<MoleculesShowcase> createState() => _MoleculesShowcaseState();
}

class _MoleculesShowcaseState extends State<MoleculesShowcase> {
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
                DSSepareted(5),
                DSSearchBar(
                  hintText: "Buscar productos...",
                  onChanged: (value) => log("Buscando: $value"),
                  onClear: () => log("Limpió búsqueda"),
                ),
                DSSepareted(2),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('DSProductCard', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                      onAddPressed: () => log('Producto agregado'),
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
                      onAddPressed: () {
                        log("Producto agregado al carrito");
                      },
                      cardSize: 80,
                    ),
                  ],
                ),
                DSSepareted(5),
                DSProductCard(
                  imageUrl:
                      'https://nikeco.vtexassets.com/arquivos/ids/677932/FD6034_001_A_PREM.jpg?v=638623623839300000',
                  title: "Zapatillas deportivas Nike Air",
                  price: "\$120.000",
                  badgeText: "New",
                  onAddPressed: () {
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
                  onAddPressed: () => log('Producto agregado'),
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
                      onTap: () => log("Ir al carrito"),
                    ),

                    DSIconCounter(
                      onTap: () => log("Ir a alertas"),
                      icon: Icons.notifications_none_rounded,
                      count: 12,
                      badgeBackgroundColor: Colors.redAccent,
                      isMedal: false,
                      badgeTextColor: Colors.white,
                      iconColor: Colors.black,
                    ),
                    DSIconCounter(
                      onTap: () {},
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
                      onTap: () {},
                      icon: Icons.favorite_border_rounded,
                      showBadge: false,
                    ),
                  ],
                ),
                DSSepareted(5),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('DSChip', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DSChip(label: "General"),
                    DSChip(
                      label: "Favoritos",
                      icon: Icons.favorite_border,
                      onTap: () {},
                    ),
                    DSChip(
                      label: "Flutter",
                      selected: true,
                      selectedColor: Colors.blueAccent,
                    ),
                    DSChip(label: "Inactivo", enabled: false),
                  ],
                ),
                DSSepareted(5),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('DSPaymentButton', style: DSTypography.displayLargeBold),
                DSSepareted(5),

                DSPaymentButton(
                  label: "Pagar con tarjeta",
                  logo: Image.asset("assets/icons/png/visa.png"),
                  onPressed: () {},
                ),

                DSSepareted(5),
                DSPaymentButton(
                  logo: Image.asset(
                    "assets/icons/png/money.png",
                    color: Colors.white,
                  ),
                  label: "Pago en efectivo",
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  borderColor: Colors.amber,
                  trailingIcon: Icons.chevron_right_rounded,
                  onPressed: () {},
                ),
                DSSepareted(5),
                DSPaymentButton(
                  label: "Apple Pay",
                  logo: Image.asset("assets/icons/png/apple-pay.png"),
                  enabled: false,
                ),
                DSSepareted(5),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('DSPromoBanner', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                DSPromoBanner(
                  title: "Ofertas de verano",
                  subtitle: "Hasta 40% de descuento en productos seleccionados",
                  imageUrl:
                      "https://nikeco.vtexassets.com/arquivos/ids/809858-1200-auto?v=638807698968530000&width=1200&height=auto&aspect=true",
                  badgeText: "Nuevo",
                  buttonLabel: "Comprar ahora",
                  size: 270,
                  onPressed: () {},
                ),
                DSSepareted(5),
                DSPromoBanner(
                  title: "Envío Gratis",
                  subtitle: "Por compras superiores a \$50.000",
                  imageUrl:
                      "https://nikeco.vtexassets.com/arquivos/ids/809858-1200-auto?v=638807698968530000&width=1200&height=auto&aspect=true",
                  isReversed: true,
                  backgroundColor: DSColorsFoundations.warning,
                  textColor: const Color.fromARGB(255, 2, 7, 171),
                ),
                DSSepareted(5),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('DSPriceSummary', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                DSPriceSummary(
                  subtotal: 120000,
                  shipping: 8000,
                  discount: 20000,
                  total: 108000,
                  buttonLabel: "Finalizar compra",
                  onButtonPressed: () {
                    log("Compra confirmada");
                  },
                ),
                DSSepareted(2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
