import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart'; // Import HomePage
import 'welcome_page.dart'; // Import WelcomePage
import 'theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const ImageLibraryApp(),
    ),
  );
}

class ImageLibraryApp extends StatelessWidget {
  const ImageLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              secondary: Colors.blueAccent,
              surface: Colors.white,
              background: Colors.grey[50]!,
              onSurface: Colors.black87,
              onBackground: Colors.black87,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.grey[50]!,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              elevation: 0,
            ),
            drawerTheme: DrawerThemeData(
              backgroundColor: Colors.white,
              scrimColor: Colors.black54,
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(color: Colors.black87),
              bodyMedium: TextStyle(color: Colors.black87),
              titleLarge: TextStyle(color: Colors.black87),
            ),
          ),
          darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.blue,
              secondary: Colors.blueAccent,
              surface: Colors.grey[900]!,
              background: Colors.black,
              onSurface: Colors.white,
              onBackground: Colors.white,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey[900]!,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            drawerTheme: DrawerThemeData(
              backgroundColor: Colors.grey[900]!,
              scrimColor: Colors.black54,
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
              titleLarge: TextStyle(color: Colors.white),
            ),
          ),
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: WelcomePage(), // Set the WelcomePage as the home
        );
      },
    );
  }
}
