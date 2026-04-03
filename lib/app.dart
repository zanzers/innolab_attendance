import 'package:flutter/material.dart';
import 'package:innolab_attendace/features/attendace/attendance_screen.dart';
import 'package:innolab_attendace/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      themeMode: ThemeMode.system,
      theme: ATheme.lightTheme,
      darkTheme: ATheme.darkTheme,
      home: AttendanceScreen(),
    );
  }
}
