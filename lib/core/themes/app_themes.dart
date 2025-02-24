import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // إضافة استيراد حزمة google_fonts

import '../constants/app_colors.dart';
import '../constants/app_defaults.dart';

class AppTheme {
  static ThemeData get defaultTheme {
    return ThemeData(
      colorSchemeSeed: AppColors.primary,
      fontFamily: GoogleFonts.cairo().fontFamily, // تغيير الخط إلى Cairo
      textTheme: GoogleFonts.cairoTextTheme(
        // تطبيق Cairo على TextTheme
        const TextTheme(
          bodyLarge: TextStyle(color: AppColors.placeholder),
          bodyMedium: TextStyle(color: AppColors.placeholder),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        elevation: 0.3,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.cairo().fontFamily, // تغيير الخط إلى Cairo
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(AppDefaults.padding),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppDefaults.borderRadius,
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(AppDefaults.padding),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppDefaults.borderRadius,
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.cairo().fontFamily, // تغيير الخط إلى Cairo
          ),
        ),
      ),
      inputDecorationTheme: defaultInputDecorationTheme,
      sliderTheme: const SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
        thumbColor: Colors.white,
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.placeholder,
        labelPadding: EdgeInsets.all(AppDefaults.padding),
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.placeholder,
        ),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
      ),
    );
  }

  /* <---- Input Decorations Theme -----> */
  static const defaultInputDecorationTheme = InputDecorationTheme(
    fillColor: AppColors.textInputBackground,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 0.1),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.1),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.1),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    suffixIconColor: AppColors.placeholder,
  );

  static const secondaryInputDecorationTheme = InputDecorationTheme(
    fillColor: AppColors.textInputBackground,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
  );

  static final otpInputDecorationTheme = InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderSide: const BorderSide(width: 0.1),
      borderRadius: BorderRadius.circular(25),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 0.1),
      borderRadius: BorderRadius.circular(25),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 0.1),
      borderRadius: BorderRadius.circular(25),
    ),
  );
}
