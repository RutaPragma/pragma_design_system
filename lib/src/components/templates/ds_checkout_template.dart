import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/components/molecules/molecules.dart';
import 'package:pragma_design_system/src/components/organisms/organisms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Template: DSCheckoutTemplate
///
/// Proceso de compra que combina DSOrderSummary, DSShippingForm, DSPaymentMethods y DSButton para confirmar compra.
/// Toda la configuración se recibe desde un [config] Map.
///
/// Ejemplo de uso:
/// ```dart
/// DSCheckoutTemplate(
///   config: {
///     "title": "Finalizar compra",
///     "orderSummary": { ... },
///     "shippingConfig": { ... },
///     "paymentConfig": { ... },
///     "buttonLabel": "Confirmar pedido",
///   },
/// )
/// ```
class DSCheckoutTemplate extends StatefulWidget {
  final Map<String, dynamic> config;

  const DSCheckoutTemplate({super.key, required this.config});

  @override
  State<DSCheckoutTemplate> createState() => _DSCheckoutTemplateState();
}

class _DSCheckoutTemplateState extends State<DSCheckoutTemplate> {
  Map<String, String> _shippingData = {};
  String? _selectedPaymentMethod;
  int currentIndex = 0;

  String checkoutTitle = '';
  String buttonLabel = '';
  Map<String, dynamic> orderSummary = {};
  Map<String, dynamic> shippingConfig = {};
  Map<String, dynamic> paymentConfig = {};
  Map<String, dynamic> alertMessage = {};
  late OrderSummaryModel orderSummaryModel;

  late final List<PaymentMethodModel> paymentList;

  @override
  void initState() {
    checkoutTitle = widget.config["title"] ?? "izar compra";
    buttonLabel = widget.config["buttonLabel"] ?? "Confirmar pedido";
    orderSummary = widget.config["orderSummary"];
    shippingConfig = widget.config["shippingConfig"];
    paymentConfig = widget.config["paymentConfig"];
    alertMessage = widget.config["alertMessage"];
    paymentList = PaymentMethodMapper.fromMapList(paymentConfig["methods"]);
    _selectedPaymentMethod = paymentList.elementAt(currentIndex).toString();
    orderSummaryModel = DSOrderSummaryMapper.fromMap(orderSummary);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color bgColor =
        widget.config["backgroundColor"] ??
        (isDark
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);

    final Color textColor =
        widget.config["textColor"] ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);

    final Color accentColor =
        widget.config["accentColor"] ??
        (isDark
            ? DSColorsFoundations.brandPrimaryDark
            : DSColorsFoundations.brandPrimary);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: DSAppBar(
        title: checkoutTitle,
        centerTitle: true,
        backgroundColor: bgColor,
        textColor: textColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DSSizesFoundations.separatorLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (orderSummary.isEmpty) ...[
              DSOrderSummary(
                orderId: orderSummaryModel.orderId,
                orderDate: orderSummaryModel.orderDate,
                orderStatus: orderSummaryModel.orderStatus,
                products: orderSummaryModel.products,
                subtotal: orderSummaryModel.subtotal,
                shipping: orderSummaryModel.shipping,
                total: orderSummaryModel.total,
                actionLabel: orderSummaryModel.actionLabel,
              ),
              const SizedBox(height: 24),
            ],

            Text(
              "Ingresa tus datos de contacto",
              style: DSTypographyFoundations.displaySmall.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            DSShippingForm(
              onSubmit: (data) => setState(() {
                log(data.toString());
                _shippingData = data;
              }),
              backgroundColor: shippingConfig["backgroundColor"],
              accentColor: shippingConfig["accentColor"],
              textColor: shippingConfig["textColor"],
              config: shippingConfig,
            ),
            const SizedBox(height: 32),

            const SizedBox(height: 12),
            DSPaymentMethods(
              title: 'Método de pago',
              methods: paymentList,
              selectedIndex: currentIndex,
              onSelected: (i) {
                currentIndex = i;
                setState(
                  () => _selectedPaymentMethod = paymentList
                      .elementAt(i)
                      .toString(),
                );
              },
            ),

            const SizedBox(height: 32),

            DSButton(
              label: buttonLabel,
              onPressed: () {
                if (_shippingData.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(alertMessage['confirmError'])),
                  );
                  return;
                }
                if (_selectedPaymentMethod == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(alertMessage['selectPayment'])),
                  );
                  return;
                }

                final checkoutData = {
                  "shipping": _shippingData,
                  "paymentMethod": _selectedPaymentMethod,
                  "order": orderSummary,
                };

                widget.config["onCheckoutComplete"]?.call(checkoutData);
              },
              backgroundColor: accentColor,
              textColor: DSColorsFoundations.textOnPrimary,
              variant: DSButtonVariant.primary,
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
