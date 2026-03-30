import 'package:evently_c18/core/remote/local/prefs_manager.dart';
import 'package:flutter/material.dart';
// observable
// publisher
class ThemeProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.light;

  init(){
   mode = PrefsManager.getTheme();
  }
  changeTheme(ThemeMode newMode){
    if(newMode==mode) return;
    mode = newMode;
    PrefsManager.saveTheme(mode);
    notifyListeners();
  }
}