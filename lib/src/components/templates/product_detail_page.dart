import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// Template: DSProductDetailPage
///
/// Muestra información detallada de un producto:
/// - Imagen principal
/// - Información del producto
/// - Calificación, descripción y botones de acción
/// - Promoción destacada (DSPromoBanner)
/// - Productos relacionados (DSProductList)
///
/// Todo se configura desde el map [config].
///
/// Ejemplo de uso:
/// ```dart
/// DSProductDetailPage(
///   config:
/// {
///     'product': {
///       'title': 'Camiseta Flutter',
///       'price': '29.900',
///       'imageUrl': '...',
///       'description': 'Camiseta oficial Flutter',
///       'rating': 4.5,
///     },
///     'relatedProducts': [ ... ],
///     'promoBanner': { ... },
///   },
/// )
/// ```
class DSProductDetailPage extends StatelessWidget {
  const DSProductDetailPage({
    super.key,
    required this.config,
    required this.onBuyNow,
    required this.onAddToCart,
    this.imageBoxFit = BoxFit.cover,
  });

  final Map<String, dynamic> config;
  final VoidCallback onBuyNow;
  final VoidCallback onAddToCart;
  final BoxFit imageBoxFit;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color bgColor =
        config['backgroundColor'] ??
        (isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);

    final Color textColor =
        config['textColor'] ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);

    final Color accentColor =
        config['accentColor'] ??
        (isDark
            ? DSColorsFoundations.brandPrimaryDark
            : DSColorsFoundations.brandPrimary);

    final product = config['product'] ?? {};
    final imageUrl = product['imageUrl'] ?? '';
    final title = product['title'] ?? 'Producto sin nombre';
    final price = product['price'] ?? '';
    final description = product['description'] ?? 'Sin descripción disponible.';
    final rating = (product['rating'] ?? 0).toDouble();
    final badgeText = product['badgeText'];
    final relatedProducts =
        config['relatedProducts'] as List<Map<String, dynamic>>?;

    final promoConfig = config['promoBanner'];
    final itemsCar = int.parse(config['itemsCar'].toString());

    return Scaffold(
      key: const ValueKey("dsProductDetailScaffold"),
      backgroundColor: bgColor,
      appBar: DSAppBar(
        key: const ValueKey("dsProductDetailAppBar"),
        title: config['appBarTitle'] ?? 'Detalle del Producto',
        centerTitle: true,
        actions: [
          Padding(
            key: const ValueKey("dsProductDetailCartPadding"),
            padding: const EdgeInsets.only(right: 8.0),
            child: DSIconCounter(
              key: const ValueKey("dsProductDetailCartCounter"),
              onTap: () {},
              icon: Icons.shopping_cart_outlined,
              // iconSize: 20,
              count: itemsCar,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        key: const ValueKey("dsProductDetailScroll"),
        padding: const EdgeInsets.all(DSSizesFoundations.separatorLarge),
        child: Column(
          key: const ValueKey("dsProductDetailColumn"),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Banner promocional opcional
            if (promoConfig != null) ...[
              DSPromoBanner(
                key: const ValueKey("dsProductDetailPromoBanner"),
                title: promoConfig['title'] ?? '',
                subtitle: promoConfig['subtitle'] ?? '',
                imageUrl: promoConfig['imageUrl'] ?? '',
                badgeText: promoConfig['badgeText'],
                buttonLabel: promoConfig['buttonLabel'],
                backgroundColor: promoConfig['backgroundColor'],
                textColor: promoConfig['textColor'],
                isReversed: promoConfig['isReversed'] ?? false,
                size: promoConfig['size'] ?? 180.0,
                onPressed: promoConfig['onPressed'],
              ),
              const SizedBox(height: 24),
            ],

            /// Imagen + badge
            Stack(
              key: const ValueKey("dsProductDetailImageStack"),
              children: [
                ClipRRect(
                  key: const ValueKey("dsProductDetailImageClip"),
                  borderRadius: BorderRadius.circular(
                    DSRadiusFoundations.radiusXL,
                  ),
                  child: Image.network(
                    key: const ValueKey("dsProductDetailImage"),
                    imageUrl,
                    fit: imageBoxFit,
                    width: double.infinity,
                    height: 280,
                  ),
                ),
                if (badgeText != null)
                  Positioned(
                    key: const ValueKey("dsProductDetailBadgePosition"),
                    top: 16,
                    left: 16,
                    child: DSBadge(
                      key: const ValueKey("dsProductDetailBadge"),
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
              key: const ValueKey("dsProductDetailTitle"),
              title,
              style: DSTypographyFoundations.displayMedium.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              key: const ValueKey("dsProductDetailPrice"),
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
              key: const ValueKey("dsProductDetailDescriptionTitle"),
              config['descriptionTitle'] ?? 'Descripción',
              style: DSTypographyFoundations.labelLarge.copyWith(
                color: textColor.withValues(alpha: 0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              key: const ValueKey("dsProductDetailDescription"),
              description,
              style: DSTypographyFoundations.bodyMedium.copyWith(
                color: textColor.withValues(alpha: 0.9),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              key: const ValueKey("dsProductDetailButtonsRow"),
              children: [
                Expanded(
                  child: DSButton(
                    key: const ValueKey("dsProductDetailAddToCartButton"),
                    label: config['addToCartLabel'] ?? 'Agregar al carrito',
                    onPressed: () => onAddToCart.call(),
                    backgroundColor: accentColor,
                    textColor: DSColorsFoundations.textOnPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DSButton(
                    key: const ValueKey("dsProductDetailBuyNowButton"),
                    label: config['buyNowLabel'] ?? 'Comprar ahora',
                    onPressed: () => onBuyNow.call(),
                    variant: DSButtonVariant.secondary,
                    backgroundColor: bgColor,
                    textColor: textColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            if (relatedProducts != null && relatedProducts.isNotEmpty) ...[
              Text(
                key: const ValueKey("dsProductDetailRelatedTitle"),
                config['relatedTitle'] ?? 'Productos relacionados',
                style: DSTypographyFoundations.labelLarge.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              DSProductList(
                key: const ValueKey("dsProductDetailRelatedList"),
                products: ProductItemMapper().fromMap(relatedProducts),
                isGrid: config['grid'] ?? true,
                showImageTopSpacing: true,
                boxFitImage: imageBoxFit,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
