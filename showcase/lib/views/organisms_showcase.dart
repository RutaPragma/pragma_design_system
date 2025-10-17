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
  int currentIndex = 0;
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
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('DSAppBar', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                DSAppBar(
                  title: "Tienda Tarragona",
                  subtitle: "Ofertas exclusivas",
                  showBackButton: true,
                  onBack: () => Navigator.pop(context),
                  actions: [
                    DSIcon(icon: Icons.favorite_border),
                    const SizedBox(width: 8),
                    DSIcon(icon: Icons.shopping_cart_outlined),
                  ],
                ),
                DSSepareted(5),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('DSBottomNav', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                DSBottomNav(
                  currentIndex: currentIndex,
                  onItemSelected: (i) {
                    currentIndex = i;
                    setState(() {});
                  },
                  items: const [
                    DSBottomNavItem(icon: Icons.home_rounded, label: "Inicio"),
                    DSBottomNavItem(
                      icon: Icons.search_rounded,
                      label: "Buscar",
                    ),
                    DSBottomNavItem(
                      icon: Icons.shopping_cart_rounded,
                      label: "Carrito",
                      badgeCount: 3,
                    ),
                    DSBottomNavItem(
                      icon: Icons.person_rounded,
                      label: "Perfil",
                    ),
                  ],
                  // backgroundColor: DSColorsFoundations.surfaceLight,
                  // activeColor: DSColorsFoundations.brandPrimary,
                  // inactiveColor: DSColorsFoundations.textHint,
                ),
                DSSepareted(5),
              ],
            ),
          ),

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
                  onProductTap: (product) => log(product.title),
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('DSCartPreview', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                DSCartPreview(
                  itemCount: 3,
                  subtotal: 245000,
                  shipping: 12000,
                  total: 257000,
                  onCheckout: () => print("Ir a checkout"),
                  onViewCart: () => print("Ver carrito"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('DSShippingForm', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                DSShippingForm(
                  onSubmit: (data) {
                    print("Dirección guardada: $data");
                  },
                  accentColor: DSColorsFoundations.brandPrimary,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('DSOrderSummary', style: DSTypography.displayLargeBold),
                DSSepareted(5),

                DSOrderSummary(
                  orderId: "A12345",
                  orderDate: "15 Octubre 2025",
                  orderStatus: "Completado",
                  products: [
                    {
                      "imageUrl":
                          "https://nikeco.vtexassets.com/arquivos/ids/734189-1200-auto?v=638708427069200000&width=1200&height=auto&aspect=true",
                      "title": "Air Zoom Pegasus 41",
                      "price": "\$120.000",
                      "quantity": 1,
                    },
                    {
                      "imageUrl":
                          "https://nikeco.vtexassets.com/arquivos/ids/806707-1200-auto?v=638836101621400000&width=1200&height=auto&aspect=true",
                      "title": "Nike Vomero 18",
                      "price": "\$80.000",
                      "quantity": 1,
                    },
                  ],
                  subtotal: "\$200.000",
                  shipping: "\$10.000",
                  total: "\$210.000",
                  actionLabel: "Ver detalles",
                  onAction: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Ver detalles de la orden")),
                    );
                  },
                ),
                DSSepareted(5),
                DSOrderSummary(
                  orderId: "B67890",
                  orderDate: "17 Octubre 2025",
                  orderStatus: "Pendiente",
                  products: [
                    {
                      "imageUrl":
                          "https://nikeco.vtexassets.com/arquivos/ids/677932/FD6034_001_A_PREM.jpg?v=638623623839300000",
                      "title": "Smartwatch Deportivo",
                      "price": "\$350.000",
                      "quantity": 1,
                    },
                  ],
                  subtotal: "\$350.000",
                  shipping: "\$0",
                  total: "\$350.000",
                  actionLabel: "Rastrear pedido",
                  // bgColor: DSColorsFoundations.buttonDisabledDark,
                  // textColor: DSColorsFoundations.textPrimary,
                  onAction: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Rastrear pedido")),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
