import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:evently_c18/core/remote/local/prefs_manager.dart';
import 'package:evently_c18/ui/start/screen/start_screen.dart';
import 'package:evently_c18/ui/onboarding/onboarding_screen.dart';
import 'package:evently_c18/ui/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "splash";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AssetsManager.logo,
        ).animate(
            onComplete: (controller) {
              bool onboardingShown = PrefsManager.isOnboardingShown();
              bool startScreenShown = PrefsManager.isStartScreenShown();
              String nextRoute;
              
              if (!onboardingShown) {
                nextRoute = OnboardingScreen.routeName;
              } else if (!startScreenShown) {
                nextRoute = StartScreen.routeName;
              } else {
                nextRoute = LoginScreen.routeName;
              }
              
              Navigator.pushReplacementNamed(context, nextRoute);
            },
        )
            .fade(duration: Duration(seconds: 2))
            .then()
            .slide(),
      ),
    );
  }
}
