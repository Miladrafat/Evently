import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late SharedPreferences sharedPreferences ;

  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static saveTheme(ThemeMode mode){
    if(mode == ThemeMode.light){
      sharedPreferences.setString("theme", "light");
    }else{
      sharedPreferences.setString("theme", "dark");
    }
  }

  static ThemeMode getTheme(){
    String theme = sharedPreferences.getString("theme")??"system";
    if(theme == "dark"){
      return ThemeMode.dark;
    }else if(theme == "light"){
      return ThemeMode.light;
    }else{
      return ThemeMode.system;
    }
  }


  static Future<void> setOnboardingShown() async {
    await sharedPreferences.setBool("onboarding_shown", true);
  }

  static bool isOnboardingShown() {
    return sharedPreferences.getBool("onboarding_shown") ?? false;
  }

  // ✅ للتحكم في عرض Start Screen مرة واحدة فقط
  static Future<void> setStartScreenShown() async {
    await sharedPreferences.setBool("start_screen_shown", true);
  }

  static bool isStartScreenShown() {
    return sharedPreferences.getBool("start_screen_shown") ?? false;
  }

}