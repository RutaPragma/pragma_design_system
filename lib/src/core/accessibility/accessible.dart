import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'accessibility_config.dart';

class Accessible extends StatelessWidget {
  final Widget child;
  final AccessibilityConfig? config;

  const Accessible({super.key, required this.child, this.config});

  @override
  Widget build(BuildContext context) {
    if (config == null) return child;

    Widget wrappedChild = child;

    if (config!.tooltip != null && config!.tooltip!.isNotEmpty) {
      return Semantics(
        identifier: config!.identifier,
        label: config!.label,
        value: config!.semantic,
        sortKey: config!.order != null
            ? OrdinalSortKey(config!.order!.toDouble())
            : null,
        hidden: config!.isHidden,
        excludeSemantics: config!.isExcludeSemantics,
        container: true,
        hint: config!.hint,
        child: Tooltip(message: config!.tooltip!, child: child),
      );
    }

    return Semantics(
      identifier: config!.identifier,
      label: config!.label,
      value: config!.semantic,
      sortKey: config!.order != null
          ? OrdinalSortKey(config!.order!.toDouble())
          : null,
      hidden: config!.isHidden,
      excludeSemantics: config!.isExcludeSemantics,
      container: true,
      hint: config!.hint,
      child: wrappedChild,
    );
  }
}
