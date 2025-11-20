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
///
/// Ejemplo de uso:
/// ```dart
/// DSProfileTemplate(
///   config: {
///     "user": {
///       "name": "Jhony Rentería",
///       "email": "jhony@correo.com",
///       "avatarUrl": "https://miapp.com/avatar.png",
///       "onEdit": () {
///       },
///     },
///     "orders": [
///       {
///         "id": "A12345",
///         "date": "15 Octubre 2025",
///         "status": "Completado",
///         "onView": () {
///         },
///       },
///     ],
///     "settings": [
///       {
///         "icon": Icons.settings,
///         "title": "Notificaciones",
///         "onTap": () {
///         },
///       },
///     ],
///     "onLogout": () {
///     },
///   },
/// )
/// ```
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
      key: const ValueKey("dsProfileTemplateScaffold"),
      backgroundColor: bgColor,
      appBar: AppBar(
        key: const ValueKey("dsProfileTemplateAppBar"),
        title: const Text(
          "Mi Perfil",
          key: ValueKey("dsProfileTemplateAppBarTitle"),
        ),

        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            key: const ValueKey("dsProfileTemplateLogoutPadding"),
            padding: const EdgeInsets.all(8.0),
            child: DSIconButton(
              key: const ValueKey("dsProfileTemplateLogoutButton"),
              icon: Icons.logout,
              onPressed: config["onLogout"],
              size: DSSize.small,
            ),
          ),
        ],
      ),
      body: SafeArea(
        key: const ValueKey("dsProfileTemplateSafeArea"),
        child: SingleChildScrollView(
          key: const ValueKey("dsProfileTemplateScroll"),
          padding: EdgeInsets.all(DSSizesFoundations.separatorLarge),
          child: Column(
            key: const ValueKey("dsProfileTemplateColumn"),
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
      key: const ValueKey("dsProfileTemplateUserHeader"),
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(DSRadiusFoundations.radiusXL),
        boxShadow: DSShadowsFoundations.shadowSmall,
      ),
      padding: EdgeInsets.all(DSSizesFoundations.separatorLarge),
      child: Row(
        key: const ValueKey("dsProfileTemplateUserRow"),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            key: const ValueKey("dsProfileTemplateUserAvatar"),
            radius: 40,
            backgroundImage: user["avatarUrl"] != null
                ? NetworkImage(user["avatarUrl"])
                : null,
            backgroundColor: accent.withValues(alpha: 0.3),
            child: user["avatarUrl"] == null
                ? Icon(
                    key: const ValueKey("dsProfileTemplateUserAvatarIcon"),
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
              key: const ValueKey("dsProfileTemplateUserInfoColumn"),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key: const ValueKey("dsProfileTemplateUserName"),
                  user["name"] ?? "Usuario",
                  style: DSTypographyFoundations.displaySmall.copyWith(
                    color: text,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  key: const ValueKey("dsProfileTemplateUserEmail"),
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
              key: const ValueKey("dsProfileTemplateEditButton"),
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
        key: const ValueKey("dsProfileTemplateOrdersEmptyText"),
        "No tienes pedidos recientes.",
        style: DSTypographyFoundations.bodyMedium.copyWith(
          color: text.withAlpha(120),
        ),
      );
    }

    return Column(
      key: const ValueKey("dsProfileTemplateOrdersSection"),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key: const ValueKey("dsProfileTemplateOrdersTitle"),
          "Mis pedidos",
          style: DSTypographyFoundations.displaySmall.copyWith(
            color: text,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          key: const PageStorageKey("dsProfileTemplateOrdersList"),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: orders.length,
          separatorBuilder: (_, __) =>
              SizedBox(height: DSSizesFoundations.separatorSmall),
          itemBuilder: (context, index) {
            final order = orders[index];
            return Container(
              key: ValueKey("dsProfileTemplateOrderCard_$index"),
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
                  Icon(
                    Icons.receipt_long_outlined,
                    key: ValueKey("dsProfileTemplateOrderIcon_$index"),
                    color: text,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      key: ValueKey(
                        "dsProfileTemplateOrderInfoColumn_$index",
                      ),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key: ValueKey(
                            "dsProfileTemplateOrderId_$index",
                          ),
                          "Pedido #${order["id"]}",
                          style: DSTypographyFoundations.bodyMedium.copyWith(
                            color: text,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          key: ValueKey(
                            "dsProfileTemplateOrderSubtitle_$index",
                          ),
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
                      key: ValueKey("dsProfileTemplateOrderButton_$index"),
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
      key: const ValueKey("dsProfileTemplateSettingsSection"),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          key: const ValueKey("dsProfileTemplateSettingsTitle"),
          "Configuración",
          style: DSTypographyFoundations.displaySmall.copyWith(
            color: text,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...settings.asMap().entries.map(
          (entry) {
            final setting = entry.value;
            return Container(
              key: ValueKey("dsProfileTemplateSetting_${entry.key}"),
              margin: EdgeInsets.only(
                bottom: DSSizesFoundations.separatorSmall,
              ),
              decoration: BoxDecoration(
                color: isDark
                    ? DSColorsFoundations.backgroundSecondaryDark
                    : DSColorsFoundations.surfaceLight,
                borderRadius:
                    BorderRadius.circular(DSRadiusFoundations.radiusMD),
                boxShadow: DSShadowsFoundations.shadowSmall,
              ),
              child: ListTile(
                key: ValueKey("dsProfileTemplateSettingTile_${entry.key}"),
                leading: Icon(
                  setting["icon"] ?? Icons.settings,
                  key: ValueKey("dsProfileTemplateSettingIcon_${entry.key}"),
                  color: text,
                ),
                title: Text(
                  setting["title"] ?? "",
                  key: ValueKey("dsProfileTemplateSettingTitle_${entry.key}"),
                  style:
                      DSTypographyFoundations.bodyMedium.copyWith(color: text),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  key: ValueKey("dsProfileTemplateSettingArrow_${entry.key}"),
                  color: text,
                ),
                onTap: setting["onTap"],
              ),
            );
          },
        ),
      ],
    );
  }
}
