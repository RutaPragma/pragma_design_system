import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/views/theme_button.dart';

class TemplatesShowcaseMenu extends StatelessWidget {
  TemplatesShowcaseMenu({super.key});

  final List<Map<String, dynamic>> items = [
    {
      "title": "DSHomeTemplate",

      "config": {
        "title": "Inicio",
        'emptyImagePath': 'assets/images/illustraction/empty.png',
        "sections": [
          {
            "title": "Recomendados para ti",
            'emptyImagePath': 'assets/images/illustraction/empty.png',
            "grid": true,
            "products": [
              {
                "imageUrl": "https://picsum.photos/200",
                "title": "Audífonos Bluetooth",
                "price": "120.000",
              },
              {
                "imageUrl": "https://picsum.photos/201",
                "title": "Smartwatch Deportivo",
                "price": "250.000",
              },
            ],
          },
          {
            "title": "Ofertas relámpago",
            'emptyImagePath': 'assets/images/illustraction/empty.png',
            "products": [
              {
                "imageUrl": "https://picsum.photos/202",
                "title": "Cámara 4K",
                "price": "899.000",
              },
            ],
          },
        ],
      },
    },
    {
      "title": "DSProductDetailPage",
      "config": {
        "appBarTitle": "Detalle del producto",
        "accentColor": DSColorsFoundations.brandPrimary,
        "grid": true,
        "product": {
          "imageUrl":
              "https://nikeco.vtexassets.com/arquivos/ids/806707-1200-auto?v=638836101621400000&width=1200&height=auto&aspect=true",
          "title": "Zapatillas Urban X",
          "price": "250.000",
          "description":
              "Comodidad y estilo con las Zapatillas Urban X, perfectas para tu día a día.",
          "rating": 4.5,
          "badgeText": "Top Ventas",
        },
        "onAddToCart": () => log("Agregado al carrito"),
        "onBuyNow": () => log("Comprar ahora"),
        "relatedTitle": "También te puede gustar",
        "relatedProducts": [
          {
            "imageUrl":
                "https://nikeco.vtexassets.com/arquivos/ids/893589-1200-auto?v=638896609278930000&width=1200&height=auto&aspect=true",
            "title": "Zapatillas Sport Runner",
            "price": "200.000",
            "badgeText": "Nuevo",
          },
          {
            "imageUrl":
                "https://nikeco.vtexassets.com/arquivos/ids/884347-1200-auto?v=638883567117600000&width=1200&height=auto&aspect=true",
            "title": "Zapatillas Urban Classic",
            "price": "230.000",
          },
        ],
        "itemsCar": '1',
      },
    },
    {
      "title": "DSCheckoutTemplate",
      "config": {
        "title": "Confirmar compra",
        "accentColor": DSColorsFoundations.brandPrimary,
        "buttonLabel": "Finalizar pedido",
        "onCheckoutComplete": (data) {
          log("Checkout completado:");
          log(data);
        },
        "orderSummary": {
          "orderId": "ALDF782302570",
          "orderDate": "15 Octubre 2025",
          "orderStatus": "Confirmacion",
          "products": [
            {
              "imageUrl":
                  "https://nikeco.vtexassets.com/arquivos/ids/734189-1200-auto?v=638708427069200000&width=1200&height=auto&aspect=true",
              "title": "Air Zoom Pegasus 41",
              "price": "120.000",
              "quantity": 1,
            },
            {
              "imageUrl":
                  "https://nikeco.vtexassets.com/arquivos/ids/806707-1200-auto?v=638836101621400000&width=1200&height=auto&aspect=true",
              "title": "Nike Vomero 18",
              "price": "80.000",
              "quantity": 1,
            },
          ],

          "subtotal": "250.000",
          "shipping": "10.000",
          "discount": "-20.000",
          "total": "240.000",
        },
        "shippingConfig": {
          "title": "Dirección de envío",
          "fields": {
            "name": {
              "label": "Nombre completo",
              "hint": "Ej. Juan Pérez",
              "required": true,
            },
            "address": {"label": "Dirección", "hint": "Ej. Calle 56 #84 - 33"},
            "city": {"label": "Ciudad", "hint": "Ej. Cali"},
            "zip": {"label": "Código postal", "hint": "Ej. 760001"},
            "phone": {"label": "Teléfono", "hint": "+57 314 723 1734"},
          },
          "shippingMethods": [
            {"label": "Estándar", "subtitle": "3-5 días hábiles"},
            {"label": "Exprés", "subtitle": "1-2 días hábiles"},
            {"label": "Internacional", "subtitle": "5-10 días hábiles"},
          ],
          "submitLabel": "Confirmar direccion",
        },
        "paymentConfig": {
          "title": "Métodos de pago",
          "methods": [
            {
              "label": "Tarjeta de crédito",
              "iconPath": "assets/icons/png/visa.png",
              "onSelect": () => log("Tarjeta seleccionada"),
            },
            {
              "label": "Nequi / Daviplata",
              "iconPath": "assets/icons/png/visa.png",
            },
            {
              "label": "Pago contra entrega",
              "iconPath": "assets/icons/png/visa.png",
            },
          ],
        },
        "alertMessage": {
          "confirmError": "Por favor confirma tu dirección de envío...",
          "selectPayment": "Selecciona un método de pago...",
        },
        "itemsCar": '1',
      },
    },
    {
      "title": "DSAuthTemplate",
      "config": {
        "logoPath": "assets/icons/png/logo.png",
        "loginTitle": "Bienvenido de nuevo 👋",
        "registerTitle": "Únete a nuestra comunidad ✨",

        "loginConfig": {
          "texts": {
            "emailLabel": "Correo electrónico",
            "passwordLabel": "Contraseña",
            "buttonLabel": "Iniciar sesión",
          },
        },
        "registerConfig": {
          "texts": {
            "nameLabel": "Nombre completo",
            "emailLabel": "Correo",
            "passwordLabel": "Crea una contraseña",
            "buttonLabel": "Crear cuenta",
          },
          "validations": {"minPasswordLength": 6, "maxPasswordLength": 20},
        },
        "socialButtons": [
          {
            "label": "Continuar con Google",
            "icon": Icon(Icons.g_mobiledata_rounded, size: 22),
            "onPressed": () {
              log("Login con Google");
            },
          },
          {
            "label": "Continuar con Apple",
            "icon": Icon(Icons.apple, size: 22),
            "onPressed": () => log("Login con Apple"),
          },
        ],

        "onLogin": (data) => log("Login -> $data"),
        "onRegister": (data) => log("Registro -> $data"),
        "loginAccessibility": {
          "logo": {
            "label": "Logo",
            "semantic": "Logo principal de icomers",
            "identifier": "McCXErv8UmdGRfcAY8ecBjTZEiL4j5V",
            "hint": "Login hint",
            "order": 2,
            "excludeSemantics": true,
          },
          "title": {
            "label": "Bienvenido de nuevo",
            "tooltip": "Título de bienvenida tooltip",
            "order": 1,
            "semantic": "Título de bienvenida",
            "identifier": "McCXErv8UmdGRfcAecweBjTZEiL4j5V",
            "hint": "Saludo hint",
            "excludeSemantics": true,
          },
          "login": {
            "emailField": {
              "label": "Correo electrónico",
              "tooltip": "Email ej: jhony@yopmail",
              "order": 3,
              "semantic":
                  "Correo electrónico, con el que te registraste, doble cli para escribir",
              "identifier": "McCXErv8UmdGRfcAeckaoeTZEiL4j5V",
              "hint": "Saludo hint",
              "excludeSemantics": true,
            },
            "passwordField": {
              "label": "Contraseña",
              "order": 4,
              "semantic": "Tú clave de acceso, doble cli para escribir",
              "identifier": "Mc<SJKrv34ndGRfcAecweBjTZEiL4j5V",
              "excludeSemantics": true,
            },
            "forgotPasswordText": {
              "label": "¿Olvidaste tu contraseña?",
              "order": 5,
              "semantic":
                  "Link para recupoerar contraseña, doble cli para activar",
              "identifier": "McWERrv34ndGRfcAecweBjTZEiL4j5V",
              "excludeSemantics": true,
            },
            "submitButton": {
              "label": "Entrar",
              "order": 6,
              "semantic":
                  "Boton de ingreso a la plataforma, doble cli para activar",
              "identifier": "McCXErv8UmdGRfcAecweBjTZEiL4j5V",
              "excludeSemantics": true,
            },
          },
        },
      },
    },
    {
      "title": "DSCartTemplate",
      "config": {
        "title": "Carrito de Compras",

        "products": [
          {
            "imageUrl":
                "https://nikeco.vtexassets.com/arquivos/ids/734189-1200-auto?v=638708427069200000&width=1200&height=auto&aspect=true",
            "title": "Zapatillas deportivas Air X",
            "price": "\$ 240.000",
            "badgeText": "Nuevo",
            "onView": () => log("Ver detalle del producto 1"),
          },
          {
            "imageUrl":
                "https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_t.png",
            "title":
                "Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5",
            "price": "\$ 109.9",
            "onView": () => log("Ver detalle del producto 2"),
          },
        ],

        // Resumen
        "summary": {
          "subtotal": 620000,
          "shipping": 15000,
          "taxes": 0,
          "total": 635000,
        },

        // Acciones
        "onCheckout": () => log("Ir al pago"),
        "onContinueShopping": () => log("Seguir comprando"),
        "onRemove": (p) => log("Eliminar producto: ${p["title"]}"),
        "checkoutLabel": "Pagar ahora",
        "continueLabel": "Seguir explorando",
      },
    },
    {
      "title": "DSProfileTemplate",
      "config": {
        "user": {
          "name": "Jhony Rentería",
          "email": "jhony@correo.com",
          "avatarUrl":
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmsZOshpHHXGSv16ekVAjfw_VfBn0eJrMazg&s",
          "onEdit": () => log("Editar perfil"),
        },
        "orders": [
          {
            "id": "10023",
            "date": "12 Oct 2025",
            "status": "Entregado",
            "onView": () => log("Ver pedido 10023"),
          },
          {
            "id": "10024",
            "date": "13 Oct 2025",
            "status": "En tránsito",
            "onView": () => log("Ver pedido 10024"),
          },
        ],
        "settings": [
          {
            "icon": Icons.lock_outline,
            "title": "Cambiar contraseña",
            "onTap": () => log("Cambiar contraseña"),
          },
          {
            "icon": Icons.notifications_outlined,
            "title": "Notificaciones",
            "onTap": () => log("Configurar notificaciones"),
          },
          {
            "icon": Icons.help_outline,
            "title": "Ayuda y soporte",
            "onTap": () => log("Abrir ayuda"),
          },
        ],
        "onLogout": () => log("Cerrar sesión"),
      },
    },
  ];

  Widget getWidget(String widget, dynamic config) {
    switch (widget) {
      case 'DSHomeTemplate':
        return DSHomeTemplate(
          onNavItemSelect: (_) {},
          onAddPressed: (productItem) {
            log(productItem.title, name: "ADD");
          },
          onTapPressed: (productItem) {
            log(productItem.title, name: "DETAIL");
          },
          config: config,
          selectIndex: 0,
          onSearch: (String p1) {},
        );
      case 'DSProductDetailPage':
        return DSProductDetailPage(
          config: config,
          onBuyNow: () {},
          onAddToCart: () {},
        );
      case 'DSCheckoutTemplate':
        return DSCheckoutTemplate(config: config);
      case 'DSAuthTemplate':
        return Scaffold(
          appBar: DSAppBar(backgroundColor: Colors.transparent, actions: []),
          body: DSAuthTemplate(
            config: config,
            onLogin: (_, __) {},
            onRegister: (_) {},
          ),
        );
      case 'DSCartTemplate':
        return Scaffold(
          appBar: DSAppBar(backgroundColor: Colors.transparent, actions: []),
          body: DSCartTemplate(
            config: config,
            onRemove: (_) {},
            onAdd: (_) {},
            onDelete: (id) {},
          ),
        );
      case 'DSProfileTemplate':
        return DSProfileTemplate(config: config);
      default:
        return DSProductDetailPage(
          config: config,
          onBuyNow: () {},
          onAddToCart: () {},
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates'),
        centerTitle: true,
        actions: [ThemeButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            title: Text(items[index]['title']),
            trailing: Icon(Icons.arrow_circle_right_outlined),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    getWidget(items[index]['title'], items[index]['config']),
              ),
            ),
          ),
          separatorBuilder: (_, __) => Divider(),
          itemCount: items.length,
        ),
      ),
    );
  }
}
