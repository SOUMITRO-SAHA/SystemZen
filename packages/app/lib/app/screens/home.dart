import 'package:flutter/material.dart';

/// Home page displayed inside the global scaffold body.
///
/// Does not define its own [AppBar]; the global [GlobalAppBar] is
/// managed at the application level in [App].
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You have pushed the button this many times:'),
        ],
      ),
    );
  }
}
