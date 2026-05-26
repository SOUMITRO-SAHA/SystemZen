import 'package:app/app/screens/home.dart';
import 'package:app/shared/widgets/common/common.dart';
import 'package:flutter/material.dart';

/// Root application widget.
///
/// Configures [MaterialApp] with theme and sets the global app bar
/// via [GlobalAppBar] on the home scaffold.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SystemZen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Scaffold(
        appBar: GlobalAppBar(title: 'SystemZen'),
        body: HomePage(),
      ),
    );
  }
}
