import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extension/custom_theme_extension.dart';
import '../utils/color.dart';

ThemeData darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      extensions: [CustomThemeExtension.darkMode],
      colorScheme: base.colorScheme.copyWith(
        background: MyColors.backgroundDark,
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: MyColors.backgroundDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: MyColors.greyBackground,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: MyColors.greyDark,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: IconThemeData(
          color: MyColors.greyDark,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.greenDark,
          foregroundColor: MyColors.backgroundDark,
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: MyColors.greyBackground,
        modalBackgroundColor: MyColors.greyBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
      ),
      dialogBackgroundColor: MyColors.greyBackground,
      dialogTheme: DialogTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
}
