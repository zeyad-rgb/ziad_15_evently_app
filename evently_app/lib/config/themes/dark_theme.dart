import 'package:evently_v2/config/themes/themes_manager.dart';
import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkTheme extends ThemesManager {
  @override
  Color get background => ColorsManager.black10;

  @override
  Color get primaryColor => ColorsManager.blue56;

  @override
  Color get secondryColor => ColorsManager.whiteF4;

  @override
  Color get textColor => ColorsManager.whiteF0;

  @override
  ThemeData get themeData => ThemeData(

    primaryColor: primaryColor,
    primaryColorLight: ColorsManager.whiteF4,
    primaryColorDark: ColorsManager.white,
    scaffoldBackgroundColor: background,
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        color: primaryColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(color: secondryColor),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: ColorsManager.white,
        padding: EdgeInsets.all(16.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16.r),
          side: BorderSide(color: primaryColor),
        ),
      ),
    ),
    textTheme: TextTheme(
      labelLarge: GoogleFonts.inter(color: secondryColor, fontSize: 22.sp),
      labelMedium: GoogleFonts.inter(color: secondryColor, fontSize: 20.sp),
      labelSmall: GoogleFonts.inter(color: secondryColor, fontSize: 16.sp),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
      backgroundColor: background,
      elevation: 0,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: background,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      backgroundColor: ColorsManager.transparent,
      selectedItemColor: ColorsManager.whiteF4,
      unselectedItemColor: ColorsManager.whiteF4,
      elevation: 0,
    ),
  );
}
