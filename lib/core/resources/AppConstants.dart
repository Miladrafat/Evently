
import 'AssetsManager.dart';
import 'package:flutter/material.dart';

abstract final class AppConstants {
  static const String emailRegex = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const List<String> EventType=[
    "Sport",
    "birthday",
    "book club",
    "Exhibition",
    "Meeting"
  ];

  static const Map<String,String> EventTypeimagesLight = {
    "Sport": AssetsManager.sport_light,
    "birthday": AssetsManager.birthday_light,
    "book club": AssetsManager.book_light,
    "Exhibition": AssetsManager.exhibition_light,
    "Meeting": AssetsManager.meeting_light
  };


  static const Map<String,String> EventTypeimagesDark = {
    "Sport": AssetsManager.sport_dark,
    "birthday": AssetsManager.birthday_dark,
    "book club": AssetsManager.book_dark,
    "Exhibition": AssetsManager.exhibition_dark,
    "Meeting": AssetsManager.meeting_dark
  };

  static String getEventImage(String eventType, ThemeMode themeMode) {
    final isLight = themeMode == ThemeMode.light;
    final imageMap = isLight ? EventTypeimagesLight : EventTypeimagesDark;
    return imageMap[eventType] ?? (isLight 
        ? AssetsManager.sport_light 
        : AssetsManager.sport_dark);
  }

  static Map<String,String> EventTypeimages = EventTypeimagesLight;
}


