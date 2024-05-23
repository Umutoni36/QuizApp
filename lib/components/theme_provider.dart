import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  late SharedPreferences _prefs;
  late bool _darkTheme;

  ThemeProvider() {
    _darkTheme = false; // default theme
    _loadThemeFromPrefs();
  }

  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    _saveThemeToPrefs(value);
    notifyListeners();
  }

  Future<void> _loadThemeFromPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _darkTheme = _prefs.getBool('darkTheme') ?? false;
    notifyListeners();
  }

  Future<void> _saveThemeToPrefs(bool value) async {
    await _prefs.setBool('darkTheme', value);
  }

  Future<bool> getTheme() async {
    await _loadThemeFromPrefs();
    return _darkTheme;
  }
}
