/// A compact sliding pill-style tab bar widget.
///
/// Provides a horizontal tab bar where the selected tab is highlighted by a
/// rounded "pill" that smoothly animates between positions. Suitable for
/// segmented controls, mode switches, and small navigation areas where a
/// full [TabBar] feels heavy.
library;

import 'package:flutter/material.dart';

/// Configuration for a single tab in [PillTabBar].
@immutable
class PillTab {
  /// Text label rendered inside the tab.
  final String label;

  /// Optional leading icon rendered before [label].
  final IconData? icon;

  const PillTab({required this.label, this.icon});
}

/// A horizontal tab bar where the selected tab is indicated by a rounded
/// pill that slides between positions.
///
/// ```dart
/// PillTabBar(
///   tabs: const [
///     PillTab(label: 'Body', icon: Icons.menu_book_outlined),
///     PillTab(label: 'Sketch', icon: Icons.edit_outlined),
///   ],
///   index: _index,
///   onChanged: (i) => setState(() => _index = i),
/// )
/// ```
///
/// Supports two or more tabs. Colors and typography fall back to the ambient
/// [Theme] when not specified.
class PillTabBar extends StatelessWidget {
  /// The tabs to display. Must contain at least one item.
  final List<PillTab> tabs;

  /// Currently selected tab index, in `[0, tabs.length)`.
  final int index;

  /// Called with the new index when the user taps a tab.
  final ValueChanged<int> onChanged;

  /// Overall height of the tab bar.
  final double height;

  /// Color of the moving pill (selected indicator).
  ///
  /// Defaults to [ColorScheme.onSurface] from the ambient theme.
  final Color? pillColor;

  /// Foreground color (icon/text) of the selected tab.
  ///
  /// Defaults to [ColorScheme.surface] from the ambient theme.
  final Color? selectedForeground;

  /// Background color of the entire bar.
  ///
  /// Defaults to a subtle surface color derived from the theme.
  final Color? backgroundColor;

  /// Foreground color (icon/text) of unselected tabs.
  ///
  /// Defaults to a muted color derived from the theme.
  final Color? unselectedForeground;

  /// Base text style for tab labels. The color is overridden by
  /// [selectedForeground] / [unselectedForeground].
  ///
  /// Defaults to [TextTheme.labelMedium] with weight 800.
  final TextStyle? textStyle;

  /// Animation duration for the sliding pill and color transitions.
  final Duration duration;

  /// Animation curve for the sliding pill and color transitions.
  final Curve curve;

  /// Outer corner radius of the bar (and the moving pill, minus padding).
  ///
  /// Defaults to a fully rounded shape.
  final BorderRadius? borderRadius;

  /// Inset of the pill from the bar edge.
  final EdgeInsets pillPadding;

  /// Size of the optional [PillTab.icon].
  final double iconSize;

  /// Gap between icon and label.
  final double iconLabelSpacing;

  /// Drop shadow under the moving pill. Pass an empty list to disable.
  final List<BoxShadow>? pillShadow;

  /// Creates a sliding pill tab bar. [tabs] must be non-empty and [index]
  /// must be in `[0, tabs.length)`.
  const PillTabBar({
    super.key,
    required this.tabs,
    required this.index,
    required this.onChanged,
    this.height = 32,
    this.pillColor,
    this.selectedForeground,
    this.backgroundColor,
    this.unselectedForeground,
    this.textStyle,
    this.duration = const Duration(milliseconds: 240),
    this.curve = Curves.easeOutCubic,
    this.borderRadius,
    this.pillPadding = const EdgeInsets.all(2),
    this.iconSize = 13,
    this.iconLabelSpacing = 4,
    this.pillShadow,
  }) : assert(tabs.length > 0, 'tabs must not be empty'),
       assert(
         index >= 0 && index < tabs.length,
         'index must be in [0, tabs.length)',
       );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final radius = borderRadius ?? BorderRadius.circular(999);

    final resolvedPillColor = pillColor ?? scheme.onSurface;
    final resolvedSelectedFg = selectedForeground ?? scheme.surface;
    final resolvedUnselectedFg =
        unselectedForeground ?? scheme.onSurface.withValues(alpha: 0.55);
    final resolvedBackground =
        backgroundColor ?? scheme.onSurface.withValues(alpha: 0.06);
    final resolvedTextStyle =
        textStyle ??
        (theme.textTheme.labelMedium ?? const TextStyle(fontSize: 11)).copyWith(
          fontWeight: FontWeight.w800,
        );
    final resolvedShadow =
        pillShadow ??
        [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ];

    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / tabs.length;
          final pillWidth = tabWidth - pillPadding.horizontal;
          final pillHeight = height - pillPadding.vertical;

          return DecoratedBox(
            decoration: BoxDecoration(
              color: resolvedBackground,
              borderRadius: radius,
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: duration,
                  curve: curve,
                  left: pillPadding.left + index * tabWidth,
                  top: pillPadding.top,
                  width: pillWidth,
                  height: pillHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: resolvedPillColor,
                      borderRadius: radius,
                      boxShadow: resolvedShadow,
                    ),
                  ),
                ),
                Row(
                  children: List.generate(tabs.length, (i) {
                    return Expanded(
                      child: _PillTabButton(
                        tab: tabs[i],
                        selected: i == index,
                        onTap: () => onChanged(i),
                        selectedColor: resolvedSelectedFg,
                        unselectedColor: resolvedUnselectedFg,
                        textStyle: resolvedTextStyle,
                        duration: duration,
                        curve: curve,
                        iconSize: iconSize,
                        iconLabelSpacing: iconLabelSpacing,
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PillTabButton extends StatelessWidget {
  final PillTab tab;
  final bool selected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle textStyle;
  final Duration duration;
  final Curve curve;
  final double iconSize;
  final double iconLabelSpacing;

  const _PillTabButton({
    required this.tab,
    required this.selected,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
    required this.textStyle,
    required this.duration,
    required this.curve,
    required this.iconSize,
    required this.iconLabelSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? selectedColor : unselectedColor;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedDefaultTextStyle(
        duration: duration,
        curve: curve,
        style: textStyle.copyWith(color: color),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (tab.icon != null) ...[
                TweenAnimationBuilder<Color?>(
                  tween: ColorTween(end: color),
                  duration: duration,
                  curve: curve,
                  builder: (_, c, __) =>
                      Icon(tab.icon, size: iconSize, color: c),
                ),
                SizedBox(width: iconLabelSpacing),
              ],
              Text(tab.label),
            ],
          ),
        ),
      ),
    );
  }
}
