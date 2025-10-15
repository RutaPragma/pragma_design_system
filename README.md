# Pragma Design System

## Estructura del proyecto
```
pragma_design_system/
├── lib/
│   ├── src/
│   │   ├── tokens/
│   │   │   ├── colors.dart
│   │   │   ├── spacing.dart
│   │   │   ├── typography.dart
│   │   │   ├── shadows.dart
│   │   │   ├── radius.dart
│   │   │   └── tokens.dart                    # Barril
│   │   │
│   │   ├── foundations/
│   │   │   ├── theme.dart
│   │   │   ├── design_system.dart
│   │   │   └── foundations.dart               # Barril
│   │   │
│   │   ├── components/
│   │   │   ├── atoms/
│   │   │   │   ├── buttons/
│   │   │   │   │   ├── primary_button.dart
│   │   │   │   │   ├── secondary_button.dart
│   │   │   │   │   ├── icon_button.dart
│   │   │   │   │   └── buttons.dart           # Barril local
│   │   │   │   ├── text_field.dart
│   │   │   │   ├── icon.dart
│   │   │   │   ├── badge.dart
│   │   │   │   └── atoms.dart                 # Barril
│   │   │   │
│   │   │   ├── molecules/
│   │   │   │   ├── search_bar.dart
│   │   │   │   ├── product_card.dart
│   │   │   │   ├── price_tag.dart
│   │   │   │   ├── rating_stars.dart
│   │   │   │   └── molecules.dart             # Barril
│   │   │   │
│   │   │   ├── organisms/
│   │   │   │   ├── product_grid.dart
│   │   │   │   ├── shopping_cart_summary.dart
│   │   │   │   ├── navbar.dart
│   │   │   │   └── organisms.dart             # Barril
│   │   │   │
│   │   │   ├── templates/
│   │   │   │   ├── home_template.dart
│   │   │   │   ├── product_detail_template.dart
│   │   │   │   ├── checkout_template.dart
│   │   │   │   └── templates.dart             # Barril
│   │   │   │
│   │   │   ├── pages/
│   │   │   │   ├── home_page.dart
│   │   │   │   ├── product_detail_page.dart
│   │   │   │   ├── checkout_page.dart
│   │   │   │   └── pages.dart                 # Barril
│   │   │   │
│   │   │   └── components.dart                # Barril general de componentes
│   │   │
│   │   ├── utils/
│   │   │   ├── enums.dart
│   │   │   ├── extensions.dart
│   │   │   ├── helpers.dart
│   │   │   └── utils.dart                     # Barril
│   │   │
│   │   └── src.dart                           # Barril maestro
│   │
│   └── pragma_design_system.dart              # Exporta src.dart
│
├── showcase/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── showcase_app.dart
│   │   └── views/
│   │       ├── atoms_showcase.dart
│   │       ├── molecules_showcase.dart
│   │       ├── organisms_showcase.dart
│   │       ├── templates_showcase.dart
│   │       ├── pages_showcase.dart
│   │       └── views.dart                     # Barril
│   │
│   └── pubspec.yaml
│
├── test/
│   ├── atoms/
│   ├── molecules/
│   ├── organisms/
│   └── foundations/
│
├── pubspec.yaml
├── README.md
└── CHANGELOG.md

```
