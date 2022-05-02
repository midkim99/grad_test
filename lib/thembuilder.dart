import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      primaryColor: Color.fromARGB(255, 0, 0, 0),
      scaffoldBackgroundColor: Colors.grey.shade900,
      iconTheme: IconThemeData(color: Colors.amber, opacity: 0.8),
      colorScheme: ColorScheme.dark());

  // static final lightTheme = ThemeData(
  //   scaffoldBackgroundColor: (lightTheme.backgroundColor),

  //     primaryColor: Colors.cyan[700],
  //     primarySwatch: Colors.amber,
  //     // scaffoldBackgroundColor: Colors.cyan[700],
  //     // iconTheme: IconThemeData(color: Colors.white, opacity: 0.8),
  //     // colorScheme: ColorScheme.light()
  //     );
}
