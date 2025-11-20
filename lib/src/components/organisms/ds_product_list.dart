import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';

/// Organismo: DSProductList
///
/// Lista o grilla de productos usando DSProductCard como base.
/// Admite múltiples configuraciones para adaptar el layout al contexto visual (home, catálogo, recomendaciones, etc.)
///
/// Ejemplo de uso:
/// ```dart
/// DSProductList(
///   products: [
///     ProductItem(title: 'Camiseta', price: '29.900', imageUrl: '...'),
///     ProductItem(title: 'Gorra', price: '15.000', imageUrl: '...'),
///   ],
///   isGrid: true,
///   crossAxisCount: 2,
///   onAddPressed: (item) => print(item.title),
/// )
/// ```
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

  /// Acción al presionar boton agregar producto
  final void Function(ProductItem)? onAddPressed;

  /// Acción al presionar card producto
  final void Function(ProductItem)? onTapPressed;

  /// Define si se muestra el botón de acción dentro de cada card
  final bool showAddButton;

  /// Texto del botón de acción (por defecto “Agregar”)
  final String actionLabel;

  /// Agrega o no efecto de estrella a badge
  final bool isMedal;

  /// Hace visible o no el icono de tipo de menu
  final bool showMenuChange;

  final BoxFit boxFitImage;
  final String emptyImagePath;
  final bool showImageTopSpacing;

  const DSProductList({
    super.key,
    required this.products,
    required this.isGrid,
    this.crossAxisCount = 2,
    this.spacing = DSSizesFoundations.separatorMedium,
    this.aspectRatio = 0.75,
    this.padding,
    this.onAddPressed,
    this.onTapPressed,
    this.showAddButton = true,
    this.actionLabel = "Agregar",
    this.isMedal = false,
    this.showMenuChange = true,
    this.boxFitImage = BoxFit.fill,
    this.emptyImagePath = 'assets/images/illustraction/empty.png',
    this.showImageTopSpacing = false,
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
    // final isDark = Theme.of(context).brightness == Brightness.dark;

    if (widget.products.isEmpty) {
      return Center(
        key: const ValueKey("dsProductListEmptyState"),
        child: Image.asset(
          key: const ValueKey("dsProductListEmptyImage"),
          widget.emptyImagePath,
          height: DSSizes.imageSizeXL,
          width: DSSizes.imageSizeXL,
        ),
      );
    }

    return Column(
      key: const ValueKey("dsProductListColumn"),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (widget.showMenuChange)
          Padding(
            key: const ValueKey("dsProductListTogglePadding"),
            padding: const EdgeInsets.only(right: 18),
            child: DSIconButton(
              key: const ValueKey("dsProductListToggleButton"),
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
          key: const ValueKey("dsProductListContentPadding"),
          padding:
              widget.padding ??
              EdgeInsets.all(DSSizesFoundations.separatorMedium),
          child: isGrid
              ? GridView.builder(
                  key: const PageStorageKey("dsProductListGridView"),
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
                      key: ValueKey("dsProductListGridItem_$index"),
                      onTap: () => widget.onTapPressed?.call(product),
                      child: DSProductCard(
                        key: ValueKey("dsProductListGridCard_$index"),
                        showImageTopSpacing: widget.showImageTopSpacing,
                        imageUrl: product.imageUrl,
                        title: product.title,
                        price: product.price,
                        badgeText: product.badgeText,
                        isMedal: widget.isMedal,
                        cardSize: 60,
                        boxFitImage: widget.boxFitImage,
                        footer: widget.showAddButton
                            ? null
                            : Row(
                                key: ValueKey(
                                  "dsProductListGridRatingRow_$index",
                                ),
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  DSRatingStars(
                                    key: ValueKey(
                                      "dsProductListGridRating_$index",
                                    ),
                                    rating: product.rating,
                                    size: DSSizesFoundations.iconSizeSmall,
                                  ),
                                ],
                              ),
                        onAddPressed: widget.showAddButton
                            ? () => widget.onAddPressed?.call(product)
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
                  key: const PageStorageKey("dsProductListListView"),
                  shrinkWrap: true,
                  itemCount: widget.products.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: DSSizesFoundations.separatorMedium),
                  itemBuilder: (context, index) {
                    final product = widget.products[index];
                    return GestureDetector(
                      key: ValueKey("dsProductListListItem_$index"),
                      onTap: () => widget.onAddPressed?.call(product),
                      child: DSProductCard(
                        key: ValueKey("dsProductListListCard_$index"),
                        imageUrl: product.imageUrl,
                        title: product.title,
                        price: product.price,
                        badgeText: product.badgeText,
                        isMedal: widget.isMedal,
                        boxFitImage: widget.boxFitImage,
                        showImageTopSpacing: widget.showImageTopSpacing,
                        footer: widget.showAddButton
                            ? null
                            : DSRatingStars(
                                key: ValueKey(
                                  "dsProductListListRating_$index",
                                ),
                                rating: product.rating,
                                size: DSSizesFoundations.iconSizeSmall,
                              ),
                        onAddPressed: widget.showAddButton
                            ? () => widget.onAddPressed?.call(product)
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
  const ProductItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.badgeText,
    this.rating = 0.0,
    this.amount = 1,
    this.bgColor,
    this.textColor,
    this.priceColor,
    this.badgeBackgroundColor,
    this.badgeTextColor,
  });
  final int id;
  final String imageUrl;
  final String title;
  final String price;
  final String? badgeText;
  final double rating;
  final int amount;
  final Color? bgColor;
  final Color? textColor;
  final Color? priceColor;
  final Color? badgeBackgroundColor;
  final Color? badgeTextColor;

  @override
  String toString() {
    return 'Id: $id,';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  ProductItem copyWith({
    int? id,
    String? imageUrl,
    String? title,
    String? price,
    String? badgeText,
    double? rating,
    int? amount,
    Color? bgColor,
    Color? textColor,
    Color? priceColor,
    Color? badgeBackgroundColor,
    Color? badgeTextColor,
  }) {
    return ProductItem(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      price: price ?? this.price,
      badgeText: badgeText ?? this.badgeText,
      rating: rating ?? this.rating,
      amount: amount ?? this.amount,
      bgColor: bgColor ?? this.bgColor,
      textColor: textColor ?? this.textColor,
      priceColor: priceColor ?? this.priceColor,
      badgeBackgroundColor: badgeBackgroundColor ?? this.badgeBackgroundColor,
      badgeTextColor: badgeTextColor ?? this.badgeTextColor,
    );
  }
}

class ProductItemMapper {
  List<ProductItem> fromMap(List<Map<String, dynamic>> json) {
    return json
        .map(
          (item) => ProductItem(
            id: item['id'] ?? 0,
            amount: item['amount'] ?? 1,
            imageUrl: item['imageUrl'] ?? '',
            title: item['title'] ?? '',
            price: item['price']?.toString() ?? '0',
            badgeText: item['badgeText'],
            rating: (item['rating'] ?? 0.0).toDouble(),
            bgColor: item['bgColor'] != null ? Color(item['bgColor']) : null,
            textColor: item['textColor'] != null
                ? Color(item['textColor'])
                : null,
            priceColor: item['priceColor'] != null
                ? Color(item['priceColor'])
                : null,
            badgeBackgroundColor: item['badgeBackgroundColor'],
            badgeTextColor: item['badgeTextColor'],
          ),
        )
        .toList();
  }
}
