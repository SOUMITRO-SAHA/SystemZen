import 'package:app/app/screens/home.dart';
import 'package:app/shared/theme/themes/default.dart';
import 'package:app/shared/utils/util.dart';
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
    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "DM Sans", "Manrope");

    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'SystemZen',
      themeMode: ThemeMode.dark,
      theme: theme.light(),
      darkTheme: theme.dark(),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        appBar: GlobalAppBar(title: 'SystemZen'),
        body: HomePage(),
      ),
    );
  }
}
