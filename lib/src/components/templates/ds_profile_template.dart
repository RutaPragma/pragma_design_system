import 'package:flutter/material.dart';
import 'package:pragma_design_system/src/components/atoms/atoms.dart';
import 'package:pragma_design_system/src/foundations/foundations.dart';
import 'package:pragma_design_system/src/utils/enums.dart';

/// Template: Perfil de Usuario
///
/// Muestra la información del usuario, sus pedidos recientes
/// y opciones de configuración de cuenta.
///
/// Todo el contenido se configura desde [config].
class DSProfileTemplate extends StatelessWidget {
  final Map<String, dynamic> config;

  const DSProfileTemplate({super.key, required this.config});

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
            ? DSColorsFoundations.surfaceDark
            : DSColorsFoundations.surfaceLight);
    final textColor =
        config["textColor"] ??
        (isDark
            ? DSColorsFoundations.textPrimaryDark
            : DSColorsFoundations.textPrimary);

    final user = config["user"] ?? {};
    final orders = List<Map<String, dynamic>>.from(config["orders"] ?? []);
    final settings = List<Map<String, dynamic>>.from(config["settings"] ?? []);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text("Mi Perfil"),

        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DSIconButton(
              icon: Icons.logout,
              onPressed: config["onLogout"],
              size: DSSize.small,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(DSSizesFoundations.separatorLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserHeader(user, accentColor, textColor),
              const SizedBox(height: 24),

              _buildOrdersSection(orders, accentColor, textColor, isDark),
              const SizedBox(height: 24),
              _buildSettingsSection(settings, accentColor, textColor, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader(Map<String, dynamic> user, Color accent, Color text) {
    return Container(
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusXL),
        boxShadow: DSShadowsFoundations.shadowSmall,
      ),
      padding: EdgeInsets.all(DSSizesFoundations.separatorLarge),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: user["avatarUrl"] != null
                ? NetworkImage(user["avatarUrl"])
                : null,
            backgroundColor: accent.withValues(alpha: 0.3),
            child: user["avatarUrl"] == null
                ? Icon(
                    Icons.person,
                    color: accent,
                    size: DSSizesFoundations.iconSizeLarge,
                  )
                : null,
          ),
          const SizedBox(width: 16),

          /// Nombre + correo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user["name"] ?? "Usuario",
                  style: DSTypographyFoundations.displaySmall.copyWith(
                    color: text,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  user["email"] ?? "correo@ejemplo.com",
                  style: DSTypographyFoundations.bodyMedium.copyWith(
                    color: text.withValues(alpha: 0.6),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Flexible(
            fit: FlexFit.loose,
            child: DSButton(
              label: "Editar",
              size: DSSize.small,
              onPressed: user["onEdit"],
              variant: DSButtonVariant.primary,
              isFullWidth: false,
              customWidth: 90, // ajusta según tu diseño
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersSection(
    List<Map<String, dynamic>> orders,
    Color accent,
    Color text,
    bool isDark,
  ) {
    if (orders.isEmpty) {
      return Text(
        "No tienes pedidos recientes.",
        style: DSTypographyFoundations.bodyMedium.copyWith(
          color: text.withAlpha(120),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Mis pedidos",
          style: DSTypographyFoundations.displaySmall.copyWith(
            color: text,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: orders.length,
          separatorBuilder: (_, __) =>
              SizedBox(height: DSSizesFoundations.separatorSmall),
          itemBuilder: (context, index) {
            final order = orders[index];
            return Container(
              decoration: BoxDecoration(
                color: isDark
                    ? DSColorsFoundations.surfaceDark
                    : DSColorsFoundations.surfaceLight,
                borderRadius: BorderRadius.circular(
                  DSRadiusFoundations.radiusMD,
                ),
                boxShadow: DSShadowsFoundations.shadowSmall,
              ),
              padding: EdgeInsets.all(DSSizesFoundations.separatorMedium),
              child: Row(
                children: [
                  Icon(Icons.receipt_long_outlined, color: text),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pedido #${order["id"]}",
                          style: DSTypographyFoundations.bodyMedium.copyWith(
                            color: text,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${order["date"] ?? "Sin fecha"} • ${order["status"] ?? "Pendiente"}",
                          style: DSTypographyFoundations.caption.copyWith(
                            color: text.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Flexible(
                    fit: FlexFit.loose,
                    child: DSButton(
                      label: "Ver",
                      onPressed: order["onView"],
                      size: DSSize.xs,
                      isFullWidth: false,
                      variant: DSButtonVariant.secondary,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSettingsSection(
    List<Map<String, dynamic>> settings,
    Color accent,
    Color text,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Configuración",
          style: DSTypographyFoundations.displaySmall.copyWith(
            color: text,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...settings.map(
          (setting) => Container(
            margin: EdgeInsets.only(bottom: DSSizesFoundations.separatorSmall),
            decoration: BoxDecoration(
              color: isDark
                  ? DSColorsFoundations.backgroundSecondaryDark
                  : DSColorsFoundations.surfaceLight,
              borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusMD),
              boxShadow: DSShadowsFoundations.shadowSmall,
            ),
            child: ListTile(
              leading: Icon(setting["icon"] ?? Icons.settings, color: text),
              title: Text(
                setting["title"] ?? "",
                style: DSTypographyFoundations.bodyMedium.copyWith(color: text),
              ),
              trailing: Icon(Icons.chevron_right, color: text),
              onTap: setting["onTap"],
            ),
          ),
        ),
      ],
    );
  }
}
