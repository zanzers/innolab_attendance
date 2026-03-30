import 'package:flutter/material.dart';
import 'package:innolab_attendace/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ATheme.lightTheme,
      darkTheme: ATheme.darkTheme,
    );
  }
}
