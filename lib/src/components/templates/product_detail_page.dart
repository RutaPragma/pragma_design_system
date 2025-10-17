import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// Template: Página de Detalle de Producto
///
/// Combina múltiples organismos y moléculas para mostrar:
/// - Imagen principal del producto
/// - Información detallada (nombre, precio, descripción)
/// - Calificación (DSRatingStars)
/// - Botón de acción (Agregar al carrito / Comprar)
/// - Lista de productos relacionados opcional
///

class DSProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> config;

  const DSProductDetailPage({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color bgColor = isDark
        ? const Color.fromARGB(255, 37, 51, 255)
        : DSColorsFoundations.surfaceLight;

    final Color textColor = isDark
        ? DSColorsFoundations.textPrimaryDark
        : DSColorsFoundations.textPrimary;

    final Color accentColor =
        config["accentColor"] ??
        (isDark
            ? DSColorsFoundations.brandPrimaryDark
            : DSColorsFoundations.brandPrimary);

    final product = config["product"] ?? {};
    final imageUrl = product["imageUrl"] ?? "";
    final title = product["title"] ?? "Producto sin nombre";
    final price = product["price"] ?? "";
    final description = product["description"] ?? "Sin descripción disponible.";
    final rating = (product["rating"] ?? 0).toDouble();
    final badgeText = product["badgeText"];
    final relatedProducts =
        config["relatedProducts"] as List<Map<String, dynamic>>?;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: DSAppBar(
        title: config["appBarTitle"] ?? "Detalle del Producto",
        backgroundColor: bgColor,
        textColor: textColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DSSizesFoundations.separatorLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    DSRadiusFoundations.radiusXL,
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 280,
                  ),
                ),
                if (badgeText != null)
                  Positioned(
                    top: 16,
                    left: 16,
                    child: DSBadge(
                      label: badgeText,
                      isMedal: true,
                      backgroundColor: accentColor,
                      textColor: DSColorsFoundations.textOnPrimary,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              title,
              style: DSTypographyFoundations.displayMedium.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              price,
              style: DSTypographyFoundations.bodyLarge.copyWith(
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            DSRatingStars(rating: rating),

            const SizedBox(height: 16),

            Text(
              config["descriptionTitle"] ?? "Descripción",
              style: DSTypographyFoundations.labelLarge.copyWith(
                color: textColor.withValues(alpha: 0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: DSTypographyFoundations.bodyMedium.copyWith(
                color: textColor.withValues(alpha: 0.9),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: DSButton(
                    label: config["addToCartLabel"] ?? "Agregar al carrito",
                    onPressed: config["onAddToCart"],
                    backgroundColor: accentColor,
                    textColor: DSColorsFoundations.textOnPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DSButton(
                    label: config["buyNowLabel"] ?? "Comprar ahora",
                    onPressed: config["onBuyNow"],
                    variant: DSButtonVariant.secondary,
                    backgroundColor: bgColor,
                    textColor: textColor,
                    // borderColor: accentColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            if (relatedProducts != null && relatedProducts.isNotEmpty) ...[
              Text(
                config["relatedTitle"] ?? "Productos relacionados",
                style: DSTypographyFoundations.labelLarge.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              DSProductList(
                // products: {"layout": "grid", "products": relatedProducts},
                products: ProductItemMapper().fromMap(relatedProducts),
                isGrid: config["grid"] ?? false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
