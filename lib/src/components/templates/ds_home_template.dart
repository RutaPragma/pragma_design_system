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
class DSHomeTemplate extends StatefulWidget {
  const DSHomeTemplate({
    super.key,
    required this.config,
    required this.selectIndex,
    required this.onNavItemSelect,
    required this.onSearch,
    required this.onAddPressed,
    required this.onTapPressed,
    this.boxFitImage = BoxFit.fill,
    this.showImageTopSpacing = false,
    this.badgeCount = 0,
  });
  final Map<String, dynamic> config;
  final void Function(int) onNavItemSelect;
  final void Function(String) onSearch;
  final void Function(ProductItem) onAddPressed;
  final void Function(ProductItem) onTapPressed;
  final int selectIndex;
  final BoxFit boxFitImage;
  final bool showImageTopSpacing;
  final int badgeCount;

  @override
  State<DSHomeTemplate> createState() => _DSHomeTemplateState();
}

class _DSHomeTemplateState extends State<DSHomeTemplate> {
  late int navIndex;
  @override
  void initState() {
    navIndex = widget.selectIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = isDark
        ? DSColorsFoundations.backgroundDark
        : DSColorsFoundations.backgroundPrimary;
    final textColor = isDark
        ? DSColorsFoundations.textPrimaryDark
        : DSColorsFoundations.textPrimary;

    final List<dynamic> sections = widget.config["sections"];
    final banner = widget.config["banner"];
    final emptyImagePath = widget.config["emptyImagePath"];

    return home(bg, isDark, banner, textColor, sections, emptyImagePath);
  }

  Scaffold home(
    Color bg,
    bool isDark,
    Map<String, dynamic>? banner,
    Color textColor,
    List<dynamic> sections,
    String emptyImagePath,
  ) {
    return Scaffold(
      key: const ValueKey("dsHomeTemplateScaffold"),
      backgroundColor: bg,
      appBar: AppBar(
        
        key: const ValueKey("dsHomeTemplateAppBar"),
        
        bottomOpacity: 0,
        elevation: 0,
        centerTitle: true,
        backgroundColor: isDark
            ? DSColorsFoundations.backgroundPrimaryDark
            : DSColorsFoundations.backgroundPrimary,
        title: Padding(
          key: const ValueKey("dsHomeTemplateSearchPadding"),
          padding: EdgeInsets.symmetric(
            horizontal: DSSizesFoundations.separatorSmall,
          ),

          child: DSSearchBar(
            key: const ValueKey("dsHomeTemplateSearchBar"),
            hintText: "Buscar productos...",
            onChanged: (v) {
              widget.onSearch(v);
            },
            onClear: () {
              widget.onSearch('');
            },
          ),
        ),
      ),

      body: SingleChildScrollView(
        key: const ValueKey("dsHomeTemplateScroll"),
        padding: EdgeInsets.all(DSSizesFoundations.separatorMedium),
        child: Column(
          key: const ValueKey("dsHomeTemplateColumn"),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (banner != null)
              Padding(
                key: const ValueKey("dsHomeTemplateBannerPadding"),
                padding: EdgeInsets.only(
                  bottom: DSSizesFoundations.separatorLarge,
                ),
                child: DSPromoBanner(
                  key: const ValueKey("dsHomeTemplatePromoBanner"),
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

            for (final entry in sections.asMap().entries) ...[
              Padding(
                key: ValueKey("dsHomeTemplateSectionPadding_${entry.key}"),
                padding: EdgeInsets.only(
                  top: DSSizesFoundations.separatorLarge,
                  bottom: DSSizesFoundations.separatorSmall,
                ),
                child: Text(
                  key: ValueKey("dsHomeTemplateSectionTitle_${entry.key}"),
                  entry.value["title"] ?? "",
                  style: DSTypographyFoundations.displaySmall.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DSProductList(
                key: ValueKey("dsHomeTemplateSectionList_${entry.key}"),
                onAddPressed: (productItem) => widget.onAddPressed(productItem),
                onTapPressed: (productItem) => widget.onTapPressed(productItem),
                boxFitImage: widget.boxFitImage,
                products: ProductItemMapper().fromMap(entry.value["products"]),
                isGrid: entry.value["grid"] ?? false,
                emptyImagePath: emptyImagePath,
                showImageTopSpacing: widget.showImageTopSpacing,
              ),
            ],

            SizedBox(height: DSSizesFoundations.separatorXL),
          ],
        ),
      ),
    );
  }
}
