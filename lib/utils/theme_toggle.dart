import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeToggle {
  ThemeData lightTheme = ThemeData(
    fontFamily: 'Lato',
    scaffoldBackgroundColor: Colors.grey[300],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[300],
      centerTitle: true,
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        color: Colors.black,
        fontSize: 20.spMax,
      ),
      displaySmall: TextStyle(
        color: Colors.black,
        fontSize: 12.spMax,
      ),
      bodyMedium: TextStyle(fontSize: 25.spMax, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 16.spMax, color: Colors.white),
      labelSmall: TextStyle(fontSize: 12.spMax, color: Colors.white),
      labelMedium: TextStyle(fontSize: 16.spMax, color: Colors.black),
    ),
    cardColor: Colors.grey.withOpacity(0.9),
    brightness: Brightness.light,
    useMaterial3: true,
  );

  ThemeData darkTheme = ThemeData(
    fontFamily: 'Lato',
    scaffoldBackgroundColor: Colors.grey[700],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[700],
      centerTitle: true,
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontSize: 20.sp,
      ),
      displaySmall: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontSize: 12.sp,
      ),
      bodyMedium: TextStyle(fontSize: 25.spMax, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 16.spMax, color: Colors.black),
      labelSmall: TextStyle(fontSize: 12.spMax, color: Colors.black),
      labelMedium: TextStyle(fontSize: 16.spMax, color: Colors.white),
    ),
    cardColor: Colors.grey[200],
    brightness: Brightness.dark,
    useMaterial3: true,
  );
}
