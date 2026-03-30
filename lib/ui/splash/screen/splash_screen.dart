import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:evently_c18/ui/start/screen/start_screen.dart';
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
              Navigator.pushReplacementNamed(context, StartScreen.routeName);
            },
        )
            .fade(duration: Duration(seconds: 2))
            .then()
            .slide(),
      ),
    );
  }
}
