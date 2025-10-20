# Pragma Design System

Pragma Design System es una librería de componentes UI basada en principios de Atomic Design, pensada para acelerar el desarrollo de aplicaciones Flutter con una experiencia visual consistente y personalizable.

## ¿Qué es este proyecto?
Este proyecto provee un sistema de diseño reutilizable, escalable y fácil de implementar en cualquier app Flutter. Incluye tokens de diseño, fundamentos visuales, utilidades y una amplia variedad de componentes (átomos, moléculas, organismos, templates y páginas) listos para usar.

## Instalación y uso rápido

1. **Clona el repositorio:**
    ```sh
    git clone https://github.com/RutaPragma/pragma_design_system.git
    cd pragma_design_system
    ```
2. **Instala dependencias:**
    ```sh
    flutter pub get
    ```
3. **Ejecuta el showcase para ver todos los componentes:**
    ```sh
    cd showcase
    flutter run
    ```

4. **Agrega la dependencia a tu proyecto:**
    Si quieres usar el design system en tu app, agrega la referencia local en tu `pubspec.yaml`:
    ```yaml
    dependencies:
      pragma_design_system:
         git:
          url: https://github.com/RutaPragma/pragma_design_system.git
          ref: main
    ```

5. **Importa y usa los componentes:**
    ```dart
    import 'package:pragma_design_system/pragma_design_system.dart';
    ```

## Estructura del proyecto
```
pragma_design_system/
lib
├── pragma_design_system.dart
└── src
    ├── components
    │   ├── atoms
    │   ├── components.dart
    │   ├── molecules
    │   ├── organisms
    │   ├── pages
    │   └── templates
    ├── foundations
    │   ├── ds_colors_foundation.dart
    │   ├── ds_radius_foundations.dart
    │   ├── ds_shadows_foundations.dart
    │   ├── ds_sizes_foundations.dart
    │   ├── ds_spacing_foundations.dart
    │   ├── ds_theme_foundations.dart
    │   ├── ds_typography_foundation.dart
    │   └── foundations.dart
    ├── tokens
    │   ├── ds_colors.dart
    │   ├── ds_radius.dart
    │   ├── ds_shadows.dart
    │   ├── ds_sizes.dart
    │   ├── ds_spacing.dart
    │   ├── ds_typography.dart
    │   └── tokens.dart
    └── utils
        ├── enums.dart
        ├── extensions.dart
        ├── fade_image.dart
        ├── helpers.dart
        └── utils.dart


showcase
│   ├── icons
│   │   ├── png
│   │   └── svg
│   └── images
│       └── illustraction
├── devtools_options.yaml
├── lib
│   ├── appState
│   │   ├── theme_bloc.dart
│   │   ├── theme_event.dart
│   │   └── theme_state.dart
│   ├── main.dart
│   ├── showcase_app.dart
│   └── views
│       ├── atoms_showcase.dart
│       ├── ds_foundations_showcase.dart
│       ├── ds_tokens_showcase.dart
│       ├── home.dart
│       ├── molecules_showcase.dart
│       ├── organisms_showcase.dart
│       ├── pages_showcase.dart
│       ├── templates_showcase_menu.dart
│       ├── theme_button.dart
│       └── views.dart
├── pubspec.lock
├── pubspec.yaml
├── showcase.iml
└── test
    └── widget_test.dart

```

## Capas del sistema

El proyecto está organizado siguiendo Atomic Design. Cada capa tiene una responsabilidad clara:

### 1. Tokens
Definen los valores base reutilizables: colores, tamaños, tipografías, espaciados, radios y sombras. Son la base para mantener la coherencia visual.

**Ejemplo:**
```dart
Color colorPrimario = DSColors.primary;
double radio = DSRadius.md;
```

### 2. Foundations (Fundamentos)
Agrupan reglas visuales y estilos derivados de los tokens, como temas, tamaños, sombras y tipografías globales. Permiten centralizar la personalización visual.

**Ejemplo:**
```dart
ThemeData theme = DSThemeFoundations.lightTheme;
```

### 3. Utils (Utilidades)
Funciones, extensiones y enums de ayuda para manipular datos, imágenes, formatos, etc.

**Ejemplo:**
```dart
String capitalizado = "texto".capitalize();
```

### 4. Components (Componentes)
Contiene todos los widgets reutilizables, organizados en subcapas:

- **Atoms:** Elementos UI básicos (botones, inputs, iconos, badges, etc.).
- **Molecules:** Combinaciones simples de átomos (tarjetas de producto, barras de búsqueda, banners, etc.).
- **Organisms:** Secciones completas y complejas (listas de productos, barras de navegación, previews de carrito, etc.).
- **Templates:** Estructuras de página reutilizables (checkout, home, auth, perfil, etc.).
- **Pages:** Ejemplos de páginas completas usando templates y organismos.

Cada componente está documentado y tiene ejemplos de uso en el código fuente y en el showcase.

### 5. Showcase
App de ejemplo para visualizar y probar todos los componentes y templates del sistema. Útil como referencia y para pruebas visuales.

## Contribuir

¡Las contribuciones son bienvenidas! Si quieres mejorar el sistema, reportar bugs o proponer nuevos componentes, abre un issue o pull request.

## Licencia

Este proyecto está bajo la licencia MIT.
