import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool _isInitialized = false;

  bool get isDarkMode => _isDarkMode;
  bool get isInitialized => _isInitialized;

  ThemeProvider() {
    _loadThemePreference();
  }

  Future<void> initializeTheme() async {
    if (!_isInitialized) {
      await _loadThemePreference();
      _isInitialized = true;
    }
  }

  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode = prefs.getBool('is_dark_mode') ?? false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading theme preference: $e');
      _isDarkMode = false;
    }
  }

  Future<void> toggleTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode = !_isDarkMode;
      await prefs.setBool('is_dark_mode', _isDarkMode);
      notifyListeners();
    } catch (e) {
      debugPrint('Error toggling theme: $e');
      // Revert the change if saving fails
      _isDarkMode = !_isDarkMode;
      notifyListeners();
    }
  }

  ThemeData get themeData {
    return _isDarkMode
        ? ThemeData.dark(useMaterial3: true).copyWith(
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          )
        : ThemeData.light(useMaterial3: true).copyWith(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
  }

  static const gradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.blue, Colors.purple],
    ),
  );

  final _lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      elevation: 0,
    ),
  );

  final _darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      elevation: 0,
    ),
  );
} 