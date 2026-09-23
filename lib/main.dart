import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const systemUiStyle = SystemUiOverlayStyle(
      // Status bar background
      statusBarColor: Color(0xFF009FA8),

      // Status bar icons
      statusBarIconBrightness: Brightness.light,

      // Bottom navigation bar
      systemNavigationBarColor: Color(0xFF009FA8),

      // Bottom navigation icons
      systemNavigationBarIconBrightness: Brightness.light,

      // Remove divider
      systemNavigationBarDividerColor: Color(0xFF009FA8),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiStyle,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hospitality App',
        home: const SplashScreen(),
      ),
    );
  }
}
