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


}