import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extension/custom_theme_extension.dart';
import '../utils/color.dart';

ThemeData lightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      extensions: [CustomThemeExtension.lightMode],
      primaryColorLight: MyColors.backgroundLight,
      primaryColor: MyColors.backgroundLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: MyColors.backgroundLight,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      colorScheme: base.colorScheme.copyWith(
        background: MyColors.backgroundLight,
      ),
      scaffoldBackgroundColor: MyColors.backgroundLight,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.greenLight,
          foregroundColor: MyColors.backgroundLight,
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: MyColors.backgroundLight,
        modalBackgroundColor: MyColors.backgroundLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
      dialogBackgroundColor: MyColors.backgroundLight,
      dialogTheme: DialogTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
}
