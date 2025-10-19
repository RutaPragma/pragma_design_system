import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pragma_design_system/pragma_design_system.dart';
import 'package:showcase/views/theme_button.dart';

class OrganismsShowcase extends StatefulWidget {
  const OrganismsShowcase({super.key});

  @override
  State<OrganismsShowcase> createState() => _OrganismsShowcaseState();
}

class _OrganismsShowcaseState extends State<OrganismsShowcase> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organismos'),
        centerTitle: true,
        actions: [ThemeButton()],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('DSAppBar', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                DSAppBar(
                  title: "Tienda Tarragona",
                  subtitle: "Ofertas exclusivas",
                  showBackButton: true,
                  backgroundColor: DSColorsFoundations.brandSecondary,
                  onActionIconPress: () => log('AppBar ActionButton click'),
                  // textColor: Colors.blue,
                  onBack: () => Navigator.pop(context),
                  actions: [
                    DSIcon(
                      icon: Icons.favorite_border,
                      onPressed: () => log('AppBar ActionButton favorite'),
                    ),
                    const SizedBox(width: 8),
                    DSIcon(
                      icon: Icons.shopping_cart_outlined,
                      customColor: DSColorsFoundations.buttonDisabled,
                    ),
                  ],
                ),
                DSSepareted(5),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('DSBottomNav', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                DSBottomNav(
                  currentIndex: currentIndex,
                  onItemSelected: (i) {
                    currentIndex = i;
                    setState(() {});
                  },
                  items: const [
                    DSBottomNavItem(icon: Icons.home_rounded, label: "Inicio"),
                    DSBottomNavItem(
                      icon: Icons.search_rounded,
                      label: "Buscar",
                    ),
                    DSBottomNavItem(
                      icon: Icons.shopping_cart_rounded,
                      label: "Carrito",
                      badgeCount: 3,
                    ),
                    DSBottomNavItem(
                      icon: Icons.person_rounded,
                      label: "Perfil",
                    ),
                  ],
                  // backgroundColor: DSColorsFoundations.surfaceLight,
                  // activeColor: DSColorsFoundations.brandPrimary,
                  // inactiveColor: DSColorsFoundations.textHint,
                ),
                DSSepareted(5),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              children: [
                Text('DSProductList', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                DSProductList(
                  isGrid: true,
                  crossAxisCount: 2,
                  showAddButton: true,
                  showMenuChange: true,
                  spacing: DSSizesFoundations.separatorMedium,
                  onProductTap: (product) => log(product.title),
                  products: [
                    ProductItem(
                      imageUrl:
                          "https://nikeco.vtexassets.com/arquivos/ids/808959-500-500?v=638807696434500000",
                      title: "Zapatos Nike Air",
                      price: "\$299.000",
                      rating: 4.5,
                      badgeText: "Nuevo",
                    ),
                    ProductItem(
                      imageUrl:
                          "https://nikeco.vtexassets.com/arquivos/ids/607564-500-500?v=638549212427500000",
                      title: "Camisa Polo",
                      price: "\$159.900",
                      rating: 4.2,
                      // badgeText: "Oferta",
                    ),
                    ProductItem(
                      imageUrl:
                          "https://nikeco.vtexassets.com/arquivos/ids/846904-500-500?v=638815508479530000",
                      title: "Camisa Polo",
                      price: "\$159.900",
                      rating: 4.2,
                      // badgeText: "Oferta",
                    ),
                    ProductItem(
                      imageUrl:
                          "https://nikeco.vtexassets.com/arquivos/ids/734189-500-500?v=638708427069200000",
                      title: "Air Zoom Pegasus 41",
                      price: "\$159.900",
                      rating: 4.2,
                      // badgeText: "Oferta",
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('DSCartPreview', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                DSCartPreview(
                  itemCount: 3,
                  subtotal: 245000,
                  shipping: 12000,
                  total: 257000,
                  onCheckout: () => log("Ir a checkout"),
                  onViewCart: () => log("Ver carrito"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('DSShippingForm', style: DSTypography.displayLargeBold),
                DSSepareted(5),

                // DSShippingForm(
                //   onSubmit: (data) {
                //     log("Dirección guardada: $data");
                //   },
                //   accentColor: DSColorsFoundations.brandPrimary,
                // ),
                DSShippingForm(
                  config: {
                    "title": "Dirección de envío",
                    "fields": {
                      "name": {
                        "label": "Nombre completo",
                        "hint": "Ej. Juan Pérez",
                        "required": true,
                      },
                      "address": {
                        "label": "Dirección",
                        "hint": "Ej. Calle 56 #84 - 33",
                      },
                      "city": {"label": "Ciudad", "hint": "Ej. Cali"},
                      "zip": {"label": "Código postal", "hint": "Ej. 760001"},
                      "phone": {
                        "label": "Teléfono",
                        "hint": "+57 314 723 1734",
                      },
                    },
                    "shippingMethods": [
                      {"label": "Estándar", "subtitle": "3-5 días hábiles"},
                      {"label": "Exprés", "subtitle": "1-2 días hábiles"},
                      {
                        "label": "Internacional",
                        "subtitle": "5-10 días hábiles",
                      },
                    ],
                    "submitLabel": "Guardar dirección",
                  },
                  onSubmit: (data) {
                    print("Datos del formulario: $data");
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('DSOrderSummary', style: DSTypography.displayLargeBold),
                DSSepareted(5),

                DSOrderSummary(
                  orderId: "A12345",
                  orderDate: "15 Octubre 2025",
                  orderStatus: "Completado",
                  products: [
                    {
                      "imageUrl":
                          "https://nikeco.vtexassets.com/arquivos/ids/734189-1200-auto?v=638708427069200000&width=1200&height=auto&aspect=true",
                      "title": "Air Zoom Pegasus 41",
                      "price": "\$120.000",
                      "quantity": 1,
                    },
                    {
                      "imageUrl":
                          "https://nikeco.vtexassets.com/arquivos/ids/806707-1200-auto?v=638836101621400000&width=1200&height=auto&aspect=true",
                      "title": "Nike Vomero 18",
                      "price": "\$80.000",
                      "quantity": 1,
                    },
                  ],
                  subtotal: "\$200.000",
                  shipping: "\$10.000",
                  total: "\$210.000",
                  actionLabel: "Ver detalles",
                  onAction: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Ver detalles de la orden")),
                    );
                  },
                ),
                DSSepareted(5),
                DSOrderSummary(
                  orderId: "B67890",
                  orderDate: "17 Octubre 2025",
                  orderStatus: "Pendiente",
                  products: [
                    {
                      "imageUrl":
                          "https://nikeco.vtexassets.com/arquivos/ids/677932/FD6034_001_A_PREM.jpg?v=638623623839300000",
                      "title": "Smartwatch Deportivo",
                      "price": "\$350.000",
                      "quantity": 1,
                    },
                  ],
                  subtotal: "\$350.000",
                  shipping: "\$0",
                  total: "\$350.000",
                  actionLabel: "Rastrear pedido",
                  // bgColor: DSColorsFoundations.buttonDisabledDark,
                  // textColor: DSColorsFoundations.textPrimary,
                  onAction: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Rastrear pedido")),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('DSOrderSummary', style: DSTypography.displayLargeBold),
                DSSepareted(5),

                DSPaymentMethods(
                  title: "Métodos de pago",
                  methods: [
                    PaymentMethodModel(
                      label: "Tarjeta de crédito",
                      iconPath: "assets/icons/png/visa.png",
                      description: "Visa, MasterCard, Amex",
                    ),
                    PaymentMethodModel(
                      label: "Efectivo",
                      iconPath: "assets/icons/png/money.png",
                    ),
                    PaymentMethodModel(
                      label: "Pago contra entrega",
                      iconPath: "assets/icons/png/money2.png",
                      description: "Efectivo o datafono",
                      badge: "Recomendado",
                    ),
                  ],
                  selectedIndex: currentIndex,
                  onSelected: (i) {
                    currentIndex = i;
                    setState(() {});
                  },
                ),

                DSSepareted(5),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('DSAuthForm', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                DSAuthForm(
                  config: {
                    "title": "Bienvenido de nuevo",
                    "subtitle": "Ingresa tus credenciales",
                    "emailLabel": "Correo",
                    "emailHint": "usuario@correo.com",
                    "passwordLabel": "Clave",
                    "passwordHint": "Tu contraseña segura",
                    "forgotPasswordText": "Recuperar acceso",
                    "buttonLabel": "Iniciar sesión",
                    "minPasswordLength": 8,
                    "emailRequired": "El correo no puede estar vacío",
                    "emailInvalid": "Formato de correo incorrecto",
                    "passwordRequired": "Debes ingresar tu contraseña",
                    "passwordTooShort": "La contraseña es demasiado corta",
                  },
                  onSubmit: (email, password) {
                    log("Email: $email / Password: $password");
                  },
                  onForgotPassword: () {
                    log("Olvidó contraseña");
                  },
                ),

                DSSepareted(5),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('otro', style: DSTypography.displayLargeBold),
                DSSepareted(5),
                DSRegisterUserForm(
                  config: {
                    "title": "Crea tu cuenta",
                    "subtitle": "Regístrate para continuar",
                    "nameLabel": "Nombre y apellido",
                    "nameHint": "Ejemplo: Jhony Rentería",
                    "emailLabel": "Correo",
                    "emailHint": "usuario@correo.com",
                    "passwordLabel": "Contraseña",
                    "passwordHint": "Mínimo 8 caracteres",
                    "confirmPasswordLabel": "Repetir contraseña",
                    "confirmPasswordHint": "Confirma tu contraseña",
                    "buttonLabel": "Registrarme ahora",
                    "minPasswordLength": 8,
                    "nameRequired": "El nombre es obligatorio",
                    "emailRequired": "El correo es obligatorio",
                    "emailInvalid": "Formato de correo inválido",
                    "passwordRequired": "La contraseña es obligatoria",
                    "passwordTooShort": "Debe tener al menos 8 caracteres",
                    "confirmPasswordRequired": "Confirma la contraseña",
                    "passwordsNotMatch": "Las contraseñas no coinciden",
                  },
                  onSubmit: (data) {
                    log("Usuario: ${data['name']}, Email: ${data['email']}");
                  },
                ),

                DSSepareted(5),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text('otro', style: DSTypography.displayLargeBold),
                DSSepareted(5),

                DSSepareted(5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
