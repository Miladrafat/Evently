import 'package:evently_c18/core/resources/AppValidations.dart';
import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:evently_c18/core/resources/StringsManager.dart';
import 'package:evently_c18/core/reusable_components/custom_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/resources/dialog_utiles.dart';
import '../../../core/reusable_components/back_btn.dart';
import '../../../core/reusable_components/custom_field.dart';

class ForgetPassScreen extends StatefulWidget {
  static const String routeName = "forgetPass";

  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  late TextEditingController emailcontorllor;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    emailcontorllor = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailcontorllor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsManager.forgetPass),
        leading: BackBtn(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 40,
              children: [
                Image.asset(AssetsManager.forgetPass),
                CustomField(
                  hint: "Enter the Email",
                  prefixPath: "h",
                  controller: emailcontorllor,
                  validation: AppValidations.validateEmail,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomBtn(
                    title: StringsManager.resetPass,
                      onClick: () async {
                        if (formkey.currentState?.validate() ?? false) {
                          try {
                            DialogUtiles.showloadingdialog(context);

                            final email = emailcontorllor.text.trim();
                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              final providers =
                              user.providerData.map((e) => e.providerId);
                              if (providers.contains('google.com')) {
                                Navigator.pop(context);
                                DialogUtiles.showMessagedialog(
                                  context,
                                  "You signed in with Google. Password reset is not available. Please use your Google account settings.",
                                );
                                return;
                              }
                            }

                            await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: email,
                            );

                            Navigator.pop(context);
                            DialogUtiles.showToastmessage(
                              context,
                              "Password reset email sent successfully",
                            );
                          } on FirebaseAuthException catch (e) {
                            if (mounted) {
                              Navigator.pop(context);

                              DialogUtiles.showMessagedialog(
                                context,
                                e.code == 'user-not-found'
                                    ? "User not found"
                                    : e.message ?? e.toString(),
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              Navigator.pop(context);
                              DialogUtiles.showMessagedialog(context, e.toString());
                            }
                          }
                        }
                      },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
