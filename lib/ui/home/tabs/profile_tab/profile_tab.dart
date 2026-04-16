import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:evently_c18/core/resources/ColorsManager.dart';
import 'package:evently_c18/core/resources/StringsManager.dart';
import 'package:evently_c18/core/resources/dialog_utiles.dart';
import 'package:evently_c18/ui/home/tabs/profile_tab/widgets/settings_btn.dart';
import 'package:evently_c18/ui/login/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../providers/UserProvider.dart';
import '../../../../providers/theme_provider.dart';
import '../../screen/home_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var MyuserProvider=Provider.of<Userprovider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

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
          Text(MyuserProvider.Myuser?.name??"",style: Theme.of(context).textTheme.titleMedium,),
          Text(MyuserProvider.Myuser?.email??"",style: Theme.of(context).textTheme.labelSmall,),
          SizedBox(height: 32,),
          Column(
            spacing: 16,
            children: [

              SettingsBtn(
                  title: StringsManager.darkMode,
                  child: Switch(
                      value: themeProvider.mode == ThemeMode.dark,
                      onChanged: (value) {
                        themeProvider.changeTheme(
                          value ? ThemeMode.dark : ThemeMode.light
                        );
                      },
                  )
              ),
              SettingsBtn(
                  title: StringsManager.language,
                  onPress: () {
                    showDialog<String>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Choose Language'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text('English'),
                              selected: context.locale.languageCode == 'en',
                              onTap: () {
                                context.setLocale(Locale('en'));
                                Navigator.pop(context);
                                DialogUtiles.showToastmessage(context, 'Language changed to English');
                              },
                            ),
                            ListTile(
                              title: Text('العربية'),
                              selected: context.locale.languageCode == 'ar',
                              onTap: () {
                                context.setLocale(Locale('ar'));
                                Navigator.pop(context);
                                DialogUtiles.showToastmessage(context, 'تم تغيير اللغة إلى العربية');
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: SvgPicture.asset(AssetsManager.arrowRight,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn),)
              ),

              SettingsBtn(
                  title: StringsManager.logout,
                  onPress: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirm Logout'),
                        content: Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text('Logout', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      try {
                        final googleSignIn = GoogleSignIn();


                        await googleSignIn.signOut();


                        await FirebaseAuth.instance.signOut();

                        if (context.mounted) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            LoginScreen.routeName,
                                (route) => false,
                          );

                          DialogUtiles.showToastmessage(
                            context,
                            'Logged out successfully',
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          DialogUtiles.showMessagedialog(
                            context,
                            'Logout failed: ${e.toString()}',
                          );
                        }
                      }
                    }
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
