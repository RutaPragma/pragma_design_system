import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// Template: DSCartTemplate
///
/// Muestra una lista de productos en el carrito con opciones de eliminar o ver detalle.
/// Incluye resumen de precios y botones de acción.
///
/// Ejemplo de uso:
/// ```dart
/// DSCartTemplate(
///   config: {
///     "products": [
///       {"title": "Camiseta", "price": "29.900", "imageUrl": "..."},
///     ],
///     "summary": {
///       "subtotal": 29900,
///       "shipping": 5000,
///       "total": 34900,
///     },
///     "onCheckout": () => print('Finalizar compra'),
///   },
/// )
/// ```
class DSCartTemplate extends StatelessWidget {
  const DSCartTemplate({
    super.key,
    required this.config,
    required this.onRemove,
    required this.onAdd,
    required this.onDelete,
  });

  final Map<String, dynamic> config;
  final void Function(int id) onDelete;
  final void Function(int id) onAdd;
  final void Function(int id) onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor =
        config["backgroundColor"] ??
        (isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);
    final accentColor =
        config["accentColor"] ??
        (isDark
            ? DSColorsFoundations.brandPrimaryDark
            : DSColorsFoundations.brandPrimary);
    final textColor =
        config["textColor"] ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);

    final products = config["products"] ?? [];
    final summary = PriceSummaryMapper.fromMap(config["summary"] ?? {});

    final onCheckout = config["onCheckout"];

    final onContinueShopping = config["onContinueShopping"];

    return Scaffold(
      backgroundColor: bgColor,

      body: SafeArea(
        child: products.isEmpty
            ? _buildEmptyState(accentColor, textColor)
            : Padding(
                padding: const EdgeInsets.all(
                  DSSizesFoundations.separatorLarge,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: products.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return _buildCartItem(
                            product: product,
                            textColor: textColor,
                            accentColor: accentColor,
                            isDark: isDark,
                            onRemove: onRemove,
                            onAdd: onAdd,
                            ondelete: onDelete,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),
                    DSPriceSummary(
                      showBtnNest: false,
                      subtotal: summary.subtotal,
                      shipping: summary.shipping,
                      total: summary.total,
                      discount: summary.discount,
                      backgroundColor: isDark
                          ? DSColorsFoundations.surfaceDark
                          : DSColorsFoundations.textOnPrimary,
                      totalColor: isDark
                          ? DSColorsFoundations.textSecondaryDark
                          : DSColorsFoundations.brandSecondary,
                    ),

                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: DSButton(
                            label:
                                config["continueLabel"] ?? "Seguir comprando",
                            variant: DSButtonVariant.secondary,
                            onPressed: onContinueShopping,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DSButton(
                            label:
                                config["checkoutLabel"] ?? "Proceder al pago",
                            onPressed: onCheckout,
                            backgroundColor: accentColor,
                            textColor: isDark
                                ? DSColorsFoundations.textOnPrimaryDark
                                : DSColorsFoundations.textOnPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildCartItem({
    required Map<String, dynamic> product,
    required Color textColor,
    required Color accentColor,
    required bool isDark,
    required void Function(int id) onRemove,
    required void Function(int id) onAdd,
    required void Function(int id) ondelete,
  }) {
    return Card(
      color: isDark
          ? DSColorsFoundations.surfaceDark
          : DSColorsFoundations.surfaceLight,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Positioned(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  DSRadiusFoundations.radiusSM,
                ),
                child: Image.network(
                  product["imageUrl"],
                  width: 70,
                  height: 70,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),

            Positioned(
              left: 80,
              right: 0,
              child: Text(
                product["title"] ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: DSTypographyFoundations.bodyMedium.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 80,
              top: 35,
              child: Text(
                product["price"] ?? "",
                style: DSTypographyFoundations.bodyMedium.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: DSSizesFoundations.textSizeMedium,
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 150,
              right: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DSIconButton(
                    icon: Icons.remove,
                    onPressed: () => onRemove.call(product["id"]),
                    size: DSSize.xs,
                  ),
                  Text(
                    '${product["amount"]}',
                    style: DSTypographyFoundations.bodyMedium.copyWith(
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: DSSizesFoundations.textSizeMedium,
                    ),
                  ),
                  DSIconButton(
                    icon: Icons.add,
                    onPressed: () => onAdd.call(product["id"]),
                    size: DSSize.xs,
                    customColor: DSColorsFoundations.success.withValues(
                      alpha: 0.8,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              child: DSIconButton(
                icon: Icons.delete_outline,
                customColor: DSColorsFoundations.error.withValues(alpha: 0.8),
                onPressed: () => ondelete.call(product["id"]),
                customSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(Color accentColor, Color textColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DSIcon(
            icon: Icons.shopping_cart_outlined,
            customColor: accentColor,
            customSize: 100,
          ),
          const SizedBox(height: 16),
          Text(
            "Tu carrito está vacío",
            style: DSTypographyFoundations.displayMedium.copyWith(
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Agrega productos para continuar con tu compra",
            textAlign: TextAlign.center,
            style: DSTypographyFoundations.bodyMedium.copyWith(
              color: textColor.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
