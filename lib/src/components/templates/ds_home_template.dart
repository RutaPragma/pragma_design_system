import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/molecules/molecules.dart';
import 'package:pragma_design_system/src/components/organisms/organisms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';

/// Template principal del Home del e-commerce.
///
/// Este template combina organismos, moléculas y átomos del sistema.
/// Toda su configuración (banners, secciones, productos, textos) se
/// recibe mediante un [Map<String, dynamic>] para máxima flexibilidad.
///
/// Ejemplo de estructura del `config`:
/// ```dart
/// {
///   "title": "Inicio",
///   "banner": {
///     "imageUrl": "https://url.com/banner.jpg",
///     "title": "Ofertas de la semana",
///     "subtitle": "Hasta 50% de descuento"
///   },
///   "sections": [
///     {
///       "title": "Recomendados",
///       "products": [
///         {"imageUrl": "...", "title": "Producto 1", "price": "\$50"},
///       ]
///     },
///     ...
///   ]
/// }
/// ```
class DSHomeTemplate extends StatelessWidget {
  final Map<String, dynamic> config;

  const DSHomeTemplate({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = isDark
        ? DSColorsFoundations.backgroundDark
        : DSColorsFoundations.backgroundPrimary;
    final textColor = isDark
        ? DSColorsFoundations.textPrimaryDark
        : DSColorsFoundations.textPrimary;

    final List<dynamic> sections = config["sections"];
    final banner = config["banner"];
    final title = config["title"] ?? "Inicio";

    return Scaffold(
      backgroundColor: bg,
      appBar: DSAppBar(title: title),
      bottomNavigationBar: DSBottomNav(
        currentIndex: 0,
        items: const [
          DSBottomNavItem(icon: Icons.home_rounded, label: 'Inicio'),
          DSBottomNavItem(icon: Icons.favorite_rounded, label: 'Favoritos'),
          DSBottomNavItem(icon: Icons.person_rounded, label: 'Perfil'),
        ],
        onItemSelected: (int value) {},
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(DSSizesFoundations.separatorMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (banner != null)
              Padding(
                padding: EdgeInsets.only(
                  bottom: DSSizesFoundations.separatorLarge,
                ),
                child: DSPromoBanner(
                  title: banner["title"] ?? "Promoción especial",
                  subtitle: banner["subtitle"] ?? "",
                  imageUrl: banner["imageUrl"] ?? "",
                  backgroundColor: isDark
                      ? DSColorsFoundations.surfaceDark
                      : DSColorsFoundations.surfaceLight,
                  textColor: textColor,
                  onPressed: () {},
                ),
              ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: DSSizesFoundations.separatorSmall,
                vertical: DSSizesFoundations.separatorMedium,
              ),
              child: DSSearchBar(
                hintText: "Buscar productos...",
                onChanged: (v) {},
                onClear: () {},
              ),
            ),

            for (final section in sections) ...[
              Padding(
                padding: EdgeInsets.only(
                  top: DSSizesFoundations.separatorLarge,
                  bottom: DSSizesFoundations.separatorSmall,
                ),
                child: Text(
                  section["title"] ?? "",
                  style: DSTypographyFoundations.displaySmall.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DSProductList(
                products: ProductItemMapper().fromMap(section["products"]),
                isGrid: section["grid"] ?? false,
              ),
            ],

            SizedBox(height: DSSizesFoundations.separatorXL),
          ],
        ),
      ),
    );
  }
}
