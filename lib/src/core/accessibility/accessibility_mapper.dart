import 'accessibility_config.dart';

class AccessibilityMapper {
  static AccessibilityConfig? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return AccessibilityConfig(
      label: map['label'] as String?,
      semantic: map['semantic'] as String?,
      tooltip: map['tooltip'] as String?,
      order: map['order'] as int?,
      isHidden: (map['hidden'] as bool?) ?? false,
      isExcludeSemantics: (map['excludeSemantics'] as bool?) ?? false,
      identifier: map['identifier'] as String?,
      hint: map['hint'] as String?,
    );
  }

  /// Convierte una lista de Maps en una lista de AccessibilityConfig.
  /// Si la lista es null o vacía, devuelve una lista vacía.
  static List<AccessibilityConfig> fromMapList(
    List<Map<String, dynamic>>? list,
  ) {
    if (list == null || list.isEmpty) return const [];

    return list.map(fromMap).whereType<AccessibilityConfig>().toList();
  }
}
