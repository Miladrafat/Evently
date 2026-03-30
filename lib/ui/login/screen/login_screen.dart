import 'package:evently_c18/core/resources/AppConstants.dart';
import 'package:evently_c18/core/resources/AppValidations.dart';
import 'package:evently_c18/core/resources/StringsManager.dart';
import 'package:evently_c18/core/reusable_components/custom_btn.dart';
import 'package:evently_c18/core/reusable_components/custom_field.dart';
import 'package:evently_c18/model/onboarding_model.dart';
import 'package:evently_c18/ui/forget_pass/screen/forget_pass_screen.dart';
import 'package:evently_c18/ui/home/screen/home_screen.dart';
import 'package:evently_c18/ui/signup/screen/signup_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/AssetsManager.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController emailController ;
  late TextEditingController passwordController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringsManager.loginToYourAcc,style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 24
              ),),
              SizedBox(height: 24,),
              CustomField(
                  controller:emailController ,
                  hint: StringsManager.enterYourEmail,
                  prefixPath: AssetsManager.email,
                  validation:AppValidations.validateEmail,
              ),
              SizedBox(height: 16,),
              CustomField(
                  controller:passwordController ,
                  hint: StringsManager.enterYourPassword,
                  prefixPath: AssetsManager.lock,
                validation: AppValidations.validatePassword,
                isPassword: true,
              ),
              SizedBox(height: 8,),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgetPassScreen.routeName);
                    },
                    child: Text(StringsManager.forgetPassAsk,style: Theme.of(context).textTheme.titleLarge,)),
              ),
              SizedBox(height: 48,),
              SizedBox(
                width: double.infinity,
                child: CustomBtn(title: StringsManager.login, onClick: () {
                    // run validations from widget form
                  if( formKey.currentState?.validate()??false){
                    // authenticate with email and password
                    print(emailController.text);
                    print(passwordController.text);
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  }
                },),
              ),
              SizedBox(height: 48,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(StringsManager.dontHaveAcc,style: Theme.of(context).textTheme.labelSmall,),
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, SignupScreen.routeName);
                      },
                      child: Text(StringsManager.signUp,style: Theme.of(context).textTheme.titleLarge,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
