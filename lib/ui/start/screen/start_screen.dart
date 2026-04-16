import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c18/core/remote/local/prefs_manager.dart';
import 'package:evently_c18/core/resources/AppTheme.dart';
import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:evently_c18/core/resources/ColorsManager.dart';
import 'package:evently_c18/core/resources/StringsManager.dart';
import 'package:evently_c18/core/reusable_components/custom_btn.dart';
import 'package:evently_c18/providers/theme_provider.dart';
import 'package:evently_c18/ui/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/settings_btn.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = "start";
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AssetsManager.logo,
          height: 27,
          fit: BoxFit.fitHeight,
          color:Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AssetsManager.beingCreative,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              SizedBox(height: 24,),
              Text(StringsManager.startTitle,style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: 8,),
              Text(StringsManager.startDesc,style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringsManager.language,style: Theme.of(context).textTheme.titleSmall,),

                  Row(
                    children: [
                      SettingsBtn(
                        background: Theme.of(context).colorScheme.primary,
                        childColor: Colors.white,
                        text: StringsManager.english,
                        isSelected: context.locale.languageCode == "en",
                        onClick: () {
                            context.setLocale(Locale("en"));
                        },
                      ),
                      SettingsBtn(
                        background: Theme.of(context).colorScheme.primary,
                        childColor: Theme.of(context).colorScheme.onPrimaryContainer,
                        text: StringsManager.arabic,
                        isSelected: context.locale.languageCode == "ar",
                        onClick: () {
                          context.setLocale(Locale("ar"));

                        },
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringsManager.theme,style: Theme.of(context).textTheme.titleSmall,),

                  Row(
                    children: [
                      SettingsBtn(
                        background: Theme.of(context).colorScheme.primary,
                        childColor: Colors.white,
                        imagePath: AssetsManager.sun,
                        isSelected: themeProvider.mode==ThemeMode.light,
                        onClick: () {
                          themeProvider.changeTheme(ThemeMode.light);

                        },
                      ),
                      SettingsBtn(
                        background: Theme.of(context).colorScheme.primary,
                        childColor: Theme.of(context).colorScheme.onPrimaryContainer,
                        imagePath: AssetsManager.moon,
                        isSelected:themeProvider.mode==ThemeMode.dark,
                        onClick: () {

                          themeProvider.changeTheme(ThemeMode.dark);
                        },

                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 24,),
               SizedBox(
                 width: double.infinity,
                 child: CustomBtn(title: StringsManager.letsStart, onClick: () async {
                   await PrefsManager.setStartScreenShown();
                   if(context.mounted){
                     Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                   }
                 },),
               )
            ],
          ),
        ),
      ),
    );
  }
}
