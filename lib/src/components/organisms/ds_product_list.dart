import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// Organismo: lista o grilla de productos.
///
/// Utiliza [DSProductCard] como elemento base.
///
/// Admite múltiples configuraciones para adaptar el layout al contexto visual
/// (home, catálogo, recomendaciones, etc.)
class DSProductList extends StatefulWidget {
  final List<ProductItem> products;

  /// Define si se muestra en grilla (true) o lista (false)
  final bool isGrid;

  /// Número de columnas (solo aplica si [isGrid] = true)
  final int crossAxisCount;

  /// Espaciado horizontal y vertical entre tarjetas
  final double spacing;

  /// Relación de aspecto de las tarjetas
  final double aspectRatio;

  /// Si se desea aplicar padding interior al contenedor
  final EdgeInsetsGeometry? padding;

  /// Acción al presionar un producto
  final void Function(ProductItem)? onProductTap;

  /// Define si se muestra el botón de acción dentro de cada card
  final bool showAddButton;

  /// Texto del botón de acción (por defecto “Agregar”)
  final String actionLabel;

  /// Agrega o no efecto de estrella a badge
  final bool isMedal;

  /// Hace visible o no el icono de tipo de menu
  final bool showMenuChange;

  const DSProductList({
    super.key,
    required this.products,
    required this.isGrid,
    this.crossAxisCount = 2,
    this.spacing = DSSizesFoundations.separatorMedium,
    this.aspectRatio = 0.75,
    this.padding,
    this.onProductTap,
    this.showAddButton = true,
    this.actionLabel = "Agregar",
    this.isMedal = false,
    this.showMenuChange = true,
  });

  @override
  State<DSProductList> createState() => _DSProductListState();
}

class _DSProductListState extends State<DSProductList> {
  bool isGrid = false;
  @override
  void initState() {
    isGrid = widget.isGrid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (widget.products.isEmpty) {
      return Center(
        child: Text(
          'No hay productos disponibles',
          style: DSTypographyFoundations.bodyMedium.copyWith(
            color: isDark
                ? DSColorsFoundations.textSecondaryDark
                : DSColorsFoundations.textSecondary,
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (widget.showMenuChange)
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: DSIconButton(
              icon: Icons.apps,
              size: DSSize.small,
              onPressed: () {
                setState(() {
                  isGrid = !isGrid;
                });
              },
            ),
          ),
        Padding(
          padding:
              widget.padding ??
              EdgeInsets.all(DSSizesFoundations.separatorMedium),
          child: isGrid
              ? GridView.builder(
                  itemCount: widget.products.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.crossAxisCount,
                    crossAxisSpacing: widget.spacing,
                    mainAxisSpacing: widget.spacing,
                    childAspectRatio: widget.aspectRatio,
                  ),
                  itemBuilder: (context, index) {
                    final product = widget.products[index];
                    return GestureDetector(
                      onTap: () => widget.onProductTap?.call(product),
                      child: DSProductCard(
                        imageUrl: product.imageUrl,
                        title: product.title,
                        price: product.price,
                        badgeText: product.badgeText,
                        isMedal: widget.isMedal,
                        cardSize: 60,
                        boxFitImage: BoxFit.cover,
                        footer: widget.showAddButton
                            ? null
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  DSRatingStars(
                                    rating: product.rating,
                                    size: DSSizesFoundations.iconSizeSmall,
                                  ),
                                ],
                              ),
                        onPressed: widget.showAddButton
                            ? () => widget.onProductTap?.call(product)
                            : null,
                        // labelButton: actionLabel,
                        priceColor: product.priceColor,
                        bgColor: product.bgColor,
                        textColor: product.textColor,
                        badgeBackgroundColor: product.badgeBackgroundColor,
                        badgeTextColor: product.badgeTextColor,
                        showShadow: true,
                      ),
                    );
                  },
                )
              : ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.products.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: DSSizesFoundations.separatorMedium),
                  itemBuilder: (context, index) {
                    final product = widget.products[index];
                    return GestureDetector(
                      onTap: () => widget.onProductTap?.call(product),
                      child: DSProductCard(
                        imageUrl: product.imageUrl,
                        title: product.title,
                        price: product.price,
                        badgeText: product.badgeText,
                        isMedal: widget.isMedal,
                        boxFitImage: BoxFit.cover,
                        footer: widget.showAddButton
                            ? null
                            : DSRatingStars(
                                rating: product.rating,
                                size: DSSizesFoundations.iconSizeSmall,
                              ),
                        onPressed: widget.showAddButton
                            ? () => widget.onProductTap?.call(product)
                            : null,
                        cardSize: 100,
                        priceColor: product.priceColor,
                        bgColor: product.bgColor,
                        textColor: product.textColor,
                        badgeBackgroundColor: product.badgeBackgroundColor,
                        badgeTextColor: product.badgeTextColor,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

/// Modelo de datos para los productos de la lista.
///
/// Se mantiene simple para que sea fácilmente integrable con
/// APIs o modelos de dominio del proyecto.
class ProductItem {
  final String imageUrl;
  final String title;
  final String price;
  final String? badgeText;
  final double rating;

  final Color? bgColor;
  final Color? textColor;
  final Color? priceColor;
  final Color? badgeBackgroundColor;
  final Color? badgeTextColor;

  const ProductItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    this.badgeText,
    this.rating = 0.0,
    this.bgColor,
    this.textColor,
    this.priceColor,
    this.badgeBackgroundColor,
    this.badgeTextColor,
  });
}
