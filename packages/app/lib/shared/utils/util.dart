import 'package:flutter/material.dart';

/// Creates a [TextTheme] combining [bodyFontString] for body/label styles
/// and [displayFontString] for display/headline/title styles.
///
/// Expects fonts to be registered in `pubspec.yaml` under the `fonts` section.
/// No network calls — purely local font resolution.
TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  final TextTheme baseTextTheme = Theme.of(context).textTheme;

  final TextTheme bodyTextTheme = baseTextTheme.copyWith(
    bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontFamily: bodyFontString),
    bodyMedium: baseTextTheme.bodyMedium?.copyWith(fontFamily: bodyFontString),
    bodySmall: baseTextTheme.bodySmall?.copyWith(fontFamily: bodyFontString),
    labelLarge: baseTextTheme.labelLarge?.copyWith(fontFamily: bodyFontString),
    labelMedium: baseTextTheme.labelMedium?.copyWith(fontFamily: bodyFontString),
    labelSmall: baseTextTheme.labelSmall?.copyWith(fontFamily: bodyFontString),
  );

  final TextTheme displayTextTheme = baseTextTheme.copyWith(
    displayLarge: baseTextTheme.displayLarge?.copyWith(fontFamily: displayFontString),
    displayMedium: baseTextTheme.displayMedium?.copyWith(fontFamily: displayFontString),
    displaySmall: baseTextTheme.displaySmall?.copyWith(fontFamily: displayFontString),
    headlineLarge: baseTextTheme.headlineLarge?.copyWith(fontFamily: displayFontString),
    headlineMedium: baseTextTheme.headlineMedium?.copyWith(fontFamily: displayFontString),
    headlineSmall: baseTextTheme.headlineSmall?.copyWith(fontFamily: displayFontString),
    titleLarge: baseTextTheme.titleLarge?.copyWith(fontFamily: displayFontString),
    titleMedium: baseTextTheme.titleMedium?.copyWith(fontFamily: displayFontString),
    titleSmall: baseTextTheme.titleSmall?.copyWith(fontFamily: displayFontString),
  );

  return displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
}
