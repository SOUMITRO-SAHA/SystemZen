import 'package:flutter/material.dart';

/// A customizable global app bar widget used across the application.
///
/// Provides a consistent header with a [title], optional [leading] widget,
/// optional [actions], and theme-aware styling.
///
/// Example usage:
/// ```dart
/// GlobalAppBar(title: 'Home')
/// ```
class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title displayed in the app bar.
  final String title;

  /// Optional leading widget displayed before the title.
  final Widget? leading;

  /// Optional list of action widgets displayed after the title.
  final List<Widget>? actions;

  /// Whether to show a back button when possible. Defaults to `true`.
  final bool automaticallyImplyLeading;

  /// Creates a [GlobalAppBar] with the given [title].
  const GlobalAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Text(title),
      backgroundColor: colorScheme.inversePrimary,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      actions: actions,
    );
  }
}
