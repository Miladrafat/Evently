import 'package:flutter/material.dart';

import 'ColorsManager.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    timePickerTheme: TimePickerThemeData(
      hourMinuteColor: Colors.grey
    ),
      scaffoldBackgroundColor: ColorsManager.backgroundColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: CircleBorder()
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
          if(states.contains(WidgetState.selected)){
            return TextStyle(
              color: ColorsManager.primaryColor,
              fontSize:12 ,
              fontWeight:FontWeight.w400
            );
          }
          return TextStyle(
              color: ColorsManager.unselectedTab,
              fontSize:12 ,
              fontWeight:FontWeight.w400
          );
        },)
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: ColorsManager.secondaryColor
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: ColorsManager.primaryColor,
        secondary: ColorsManager.secondaryColor,
        onPrimaryContainer: ColorsManager.primaryColor,
       onSecondaryContainer: ColorsManager.unselectedTab,
        outline: ColorsManager.fieldBorder,
        onSecondary: Colors.white
      ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: ColorsManager.secondaryColor
      ),
      bodySmall:TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: ColorsManager.secondaryColor
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: ColorsManager.primaryColor
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Colors.white
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: ColorsManager.hintTextColor
      ),
      titleLarge: TextStyle(
        color: ColorsManager.primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.primaryColor
      ),
        bodyMedium: TextStyle(
          color: ColorsManager.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,

        )
    )
  );
  static ThemeData darkTheme = ThemeData(
      timePickerTheme: TimePickerThemeData(
          hourMinuteColor: Colors.grey
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: CircleBorder()
      ),
      scaffoldBackgroundColor: ColorsManager.darkBackgroundColor,
      navigationBarTheme: NavigationBarThemeData(
          backgroundColor: ColorsManager.darkBackgroundColor,
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
            if(states.contains(WidgetState.selected)){
              return TextStyle(
                  color: ColorsManager.darkPrimaryColor,
                  fontSize:12 ,
                  fontWeight:FontWeight.w400
              );
            }
            return TextStyle(
                color: ColorsManager.unselectedTab,
                fontSize:12 ,
                fontWeight:FontWeight.w400
            );
          },)
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ColorsManager.darkSecondaryColor
        ),
      ),
      colorScheme: ColorScheme.dark(
        secondary: ColorsManager.darkSecondaryColor,
        primary: ColorsManager.darkPrimaryColor,
        onPrimaryContainer: ColorsManager.darkOnPrimaryContainerColor,
        onSecondaryContainer: ColorsManager.unselectedTab,
          outline: ColorsManager.fieldBorderDark,
          onSecondary:ColorsManager.darkUnselected

      ),
      textTheme: TextTheme(
          titleMedium: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: ColorsManager.darkSecondaryColor
          ),
          bodySmall:TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: ColorsManager.darkSecondaryColor
          ),
          titleSmall: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: ColorsManager.onPrimaryColor
          ),
          labelMedium: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.white
          ),
          labelSmall: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: ColorsManager.darkTeritaryColor
          ),
          titleLarge: TextStyle(
              color: ColorsManager.darkPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: ColorsManager.darkPrimaryColor
          ),
          bodyMedium: TextStyle(
              color: ColorsManager.darkPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,

          )
      )
  );
}