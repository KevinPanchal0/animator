import 'package:animator/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModel themeModel = ThemeModel(toggleTheme: false);

  ThemeProvider() {
    loadPrefs();
  }

  void changeTheme() {
    themeModel.toggleTheme = !themeModel.toggleTheme;
    setPrefs();

    notifyListeners();
  }

  Future<void> loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    themeModel.toggleTheme = prefs.getBool("toggleTheme") ?? false;

    notifyListeners();
  }

  Future<void> setPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("toggleTheme", themeModel.toggleTheme);
  }
}
