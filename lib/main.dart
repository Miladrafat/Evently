import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c18/core/remote/local/prefs_manager.dart';
import 'package:evently_c18/core/resources/AppTheme.dart';
import 'package:evently_c18/core/resources/ColorsManager.dart';
import 'package:evently_c18/providers/theme_provider.dart';
import 'package:evently_c18/ui/add_event/screen/add_event_screen.dart';
import 'package:evently_c18/ui/forget_pass/screen/forget_pass_screen.dart';
import 'package:evently_c18/ui/home/screen/home_screen.dart';
import 'package:evently_c18/ui/login/screen/login_screen.dart';
import 'package:evently_c18/ui/signup/screen/signup_screen.dart';
import 'package:evently_c18/ui/splash/screen/splash_screen.dart';
import 'package:evently_c18/ui/start/screen/start_screen.dart';
import 'package:evently_c18/ui/start/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PrefsManager.init();
  await EasyLocalization.ensureInitialized();
  runApp(ChangeNotifierProvider(
      create: (context) =>ThemeProvider()..init() ,
      child: EasyLocalization(
          supportedLocales: [
            Locale('en'),
            Locale('ar',)
          ],
          path: 'assets/translations',
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: provider.mode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName:(_)=>SplashScreen(),
        StartScreen.routeName:(_)=>StartScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        HomeScreen.routeName:(_)=>HomeScreen(),
        SignupScreen.routeName:(_)=>SignupScreen(),
        ForgetPassScreen.routeName:(_)=>ForgetPassScreen(),
        AddEventScreen.routeName:(_)=>AddEventScreen()
      },
      initialRoute: StartScreen.routeName,
    );
  }
}

