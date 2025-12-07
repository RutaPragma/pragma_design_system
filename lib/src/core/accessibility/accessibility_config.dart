class AccessibilityConfig {
  const AccessibilityConfig({
    this.label,
    this.semantic,
    this.tooltip,
    this.order,
    this.isHidden = false,
    this.isExcludeSemantics = false,
    this.identifier,
    this.hint,
  });
  final String? label;
  final String? semantic;
  final String? tooltip;
  final int? order;
  final bool isHidden;
  final bool isExcludeSemantics;
  final String? identifier;
  final String? hint;

  AccessibilityConfig copyWith({
    String? label,
    String? semantic,
    String? tooltip,
    int? order,
    bool? isHidden,
    bool? isExcludeSemantics,
  }) {
    return AccessibilityConfig(
      label: label ?? this.label,
      semantic: semantic ?? this.semantic,
      tooltip: tooltip ?? this.tooltip,
      order: order ?? this.order,
      isHidden: isHidden ?? this.isHidden,
      isExcludeSemantics: isExcludeSemantics ?? this.isExcludeSemantics,
    );
  }
}
