import 'package:agency31_app/utils/base/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  ThemeData get materialTheme {
    return ThemeData(
      fontFamily: GoogleFonts.roboto().fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: MyColors.primary,
        primary: MyColors.primary,
        secondary: MyColors.secondary,
        tertiary: MyColors.tertiary,
      ),
      // textTheme: const TextTheme(
      //   bodyText2: TextStyle(
      //     color: MyColors.textColor,
      //   ),
      //   headline6: TextStyle(color: MyColors.textColor),
      //   headline5: TextStyle(color: MyColors.textColor),
      //   headline4: TextStyle(color: MyColors.textColor),
      // ),
    );
  }
}
