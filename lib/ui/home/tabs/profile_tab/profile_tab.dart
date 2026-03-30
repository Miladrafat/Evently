import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:evently_c18/core/resources/ColorsManager.dart';
import 'package:evently_c18/core/resources/StringsManager.dart';
import 'package:evently_c18/ui/home/tabs/profile_tab/widgets/settings_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16
        ),
        child: Column(children: [
          CircleAvatar(
            radius: 57,
            backgroundImage: AssetImage(AssetsManager.route),
          ),
          SizedBox(height: 16,),
          Text("John Safwat",style: Theme.of(context).textTheme.titleMedium,),
          Text("johnsafwat.route@gmail.com",style: Theme.of(context).textTheme.labelSmall,),
          SizedBox(height: 32,),
          Column(
            spacing: 16,
            children: [
              SettingsBtn(
                  title: StringsManager.darkMode,
                  child: Switch(
                      value: false,
                      onChanged: (value) {

                      },
                  )
              ),
              SettingsBtn(
                  title: StringsManager.language,
                  onPress: () {

                  },
                  child: SvgPicture.asset(AssetsManager.arrowRight,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn),)
              ),
              SettingsBtn(
                  title: StringsManager.logout,
                  onPress: () {

                  },
                  child: SvgPicture.asset(AssetsManager.logout,)
              ),
            ],
          )
        ],),
      ),
    );
  }
}
