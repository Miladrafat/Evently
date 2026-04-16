import 'package:evently_c18/core/resources/AppConstants.dart';
import 'package:evently_c18/core/resources/AppValidations.dart';
import 'package:evently_c18/core/resources/StringsManager.dart';
import 'package:evently_c18/core/reusable_components/custom_btn.dart';
import 'package:evently_c18/core/reusable_components/custom_field.dart';
import 'package:evently_c18/core/services/google_sign_in_service.dart';
import 'package:evently_c18/model/onboarding_model.dart';
import 'package:evently_c18/ui/forget_pass/screen/forget_pass_screen.dart';
import 'package:evently_c18/ui/home/screen/home_screen.dart';
import 'package:evently_c18/ui/signup/screen/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/resources/AssetsManager.dart';
import '../../../core/resources/dialog_utiles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController emailController;

  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    Future.microtask(() {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    try {
      if (!mounted) return;
      DialogUtiles.showloadingdialog(context);

      final googleSignInService = GoogleSignInService();
      final userCredential = await googleSignInService.signInWithGoogle();

      final user = userCredential.user;

      if (user == null) {
        Navigator.pop(context);
        return;
      }

      print("STEP 1: USER LOGGED IN");

      try {
        print("STEP 2: SAVING TO FIRESTORE");

        await FirebaseFirestore.instance.collection('User').doc(user.uid).set({
          'uid': user.uid,
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'photo': user.photoURL ?? '',
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        print("STEP 3: SAVED SUCCESSFULLY");
      } catch (firestoreError) {
        print("FIRESTORE ERROR: $firestoreError");
      }

      if (!mounted) return;
      Navigator.pop(context);

      DialogUtiles.showToastmessage(context, "Login Successfully");

      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        Navigator.pop(context);
        DialogUtiles.showMessagedialog(context, e.message ?? e.code);
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        DialogUtiles.showMessagedialog(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AssetsManager.logo,
          height: 27,
          fit: BoxFit.fitHeight,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringsManager.loginToYourAcc,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 24),
                CustomField(
                  controller: emailController,
                  hint: StringsManager.enterYourEmail,
                  prefixPath: AssetsManager.email,
                  validation: AppValidations.validateEmail,
                ),
                SizedBox(height: 16),
                CustomField(
                  controller: passwordController,
                  hint: StringsManager.enterYourPassword,
                  prefixPath: AssetsManager.lock,
                  validation: AppValidations.validatePassword,
                  isPassword: true,
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgetPassScreen.routeName);
                    },
                    child: Text(
                      StringsManager.forgetPassAsk,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  child: CustomBtn(
                    title: StringsManager.login,
                    onClick: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        try {
                          DialogUtiles.showloadingdialog(context);
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                          Navigator.pop(context);
                          DialogUtiles.showToastmessage(
                            context,
                            "Login Sucessfully",
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            HomeScreen.routeName,
                          );
                        } on FirebaseAuthException catch (e) {
                          Navigator.pop(context);
                          if (e.code == 'user-not-found') {
                            DialogUtiles.showMessagedialog(
                              context,
                              "user-not-found.",
                            );
                          } else if (e.code == 'wrong-password') {
                            DialogUtiles.showMessagedialog(
                              context,
                              "Wrong password provided for that user.",
                            );
                          } else {
                            DialogUtiles.showMessagedialog(
                              context,
                              e.toString(),
                            );
                          }
                        } catch (e) {
                          Navigator.pop(context);
                          DialogUtiles.showMessagedialog(context, e.toString());
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Theme.of(context,).colorScheme.outline,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        StringsManager.or,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withOpacity(0.5),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.dontHaveAcc,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          SignupScreen.routeName,
                        );
                      },
                      child: Text(
                        StringsManager.signUp,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _signInWithGoogle,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color(0xFF1F1F1F)
                              : Colors.grey.shade100,
                          border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey.shade700
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 12,
                          children: [
                            Image.asset(AssetsManager.googleIcon,height: 24,width: 24,),
                            Text(
                              StringsManager.SignWithGoogle,
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.blue
                                        : Colors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
