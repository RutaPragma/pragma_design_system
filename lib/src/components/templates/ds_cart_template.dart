import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

///Template: Carrito de Compras
///
/// Muestra una lista de productos en el carrito con opciones de eliminar o ver detalle.
/// Incluye resumen de precios y botones de acción.
class DSCartTemplate extends StatelessWidget {
  final Map<String, dynamic> config;

  const DSCartTemplate({super.key, required this.config});

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

    final products = List<Map<String, dynamic>>.from(config["products"] ?? []);
    final summary = PriceSummaryMapper.fromMap(config["summary"] ?? {});

    final onCheckout = config["onCheckout"];
    final onRemove = config["onRemove"];
    final onContinueShopping = config["onContinueShopping"];

    return Scaffold(
      backgroundColor: bgColor,

      appBar: DSAppBar(
        title: config["title"] ?? "Carrito de Compras",
        centerTitle: true,
        textColor: textColor,
        actions: [],
        backgroundColor: Colors.transparent,
      ),

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
                            onRemove: onRemove,
                            isDark: isDark,
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
    required Function? onRemove,
    required bool isDark,
  }) {
    return Card(
      color: isDark
          ? DSColorsFoundations.surfaceDark
          : DSColorsFoundations.surfaceLight,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DSSizesFoundations.separatorMedium,
          vertical: DSSizesFoundations.separatorSmall,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusSM),
              child: Image.network(
                product["imageUrl"],
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["title"] ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: DSTypographyFoundations.bodyMedium.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product["price"] ?? "",
                    style: DSTypographyFoundations.bodyMedium.copyWith(
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DSIconButton(
                  icon: Icons.edit,
                  onPressed: product["onView"],
                  size: DSSize.small,
                  customColor: DSColorsFoundations.buttonSecondary.withValues(
                    alpha: 0.8,
                  ),
                ),
                const SizedBox(width: 8),
                DSIconButton(
                  icon: Icons.delete_outline,
                  customColor: DSColorsFoundations.error.withValues(alpha: 0.8),
                  onPressed: () => onRemove?.call(product),
                  size: DSSize.small,
                ),
              ],
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
