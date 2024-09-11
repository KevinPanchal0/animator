import 'package:animator/pages/screens/detail_screen.dart';
import 'package:animator/pages/screens/home_page.dart';
import 'package:animator/pages/screens/setting_screen.dart';
import 'package:animator/pages/screens/splash_screen.dart';
import 'package:animator/provider/theme_provider.dart';
import 'package:animator/utils/theme_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeToggle =
        Provider.of<ThemeProvider>(context).themeModel.toggleTheme;
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeToggle().lightTheme,
        darkTheme: ThemeToggle().darkTheme,
        themeMode: (themeToggle == false) ? ThemeMode.light : ThemeMode.dark,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          'home_page': (context) => const HomePage(),
          'detail_page': (context) => const DetailScreen(),
          'settings_screen': (context) => const SettingScreen(),
        },
      ),
    );
  }
}
