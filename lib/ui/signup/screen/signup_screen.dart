import 'package:evently_c18/ui/login/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/AppValidations.dart';
import '../../../core/resources/AssetsManager.dart';
import '../../../core/resources/StringsManager.dart';
import '../../../core/reusable_components/custom_btn.dart';
import '../../../core/reusable_components/custom_field.dart';
import '../../home/screen/home_screen.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = "signup";
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController emailController ;
  late TextEditingController nameController ;
  late TextEditingController passwordController ;
  late TextEditingController confirmPasswordController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
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
              Text(StringsManager.createYourAcc,style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 24
              ),),
              SizedBox(height: 24,),
              CustomField(
                controller:nameController ,
                hint: StringsManager.enterYourName,
                prefixPath: AssetsManager.profile,
                validation:AppValidations.validateName,
              ),
              SizedBox(height: 16,),
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
              SizedBox(height: 16,),
              CustomField(
                controller:confirmPasswordController ,
                hint: StringsManager.confirmYourPassword,
                prefixPath: AssetsManager.lock,
                validation: (value) {
                  if(value != passwordController.text){
                    return "passwords don't match";
                  }
                  return null;
                },
                isPassword: true,
              ),
              SizedBox(height: 48,),
              SizedBox(
                width: double.infinity,
                child: CustomBtn(title: StringsManager.signUp, onClick: () async {
                  // run validations from widget form
                  if( formKey.currentState?.validate()??false){
                    // authenticate with email and password
                    try{
                      var credential =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text
                      );
                      print("user id : ${credential.user?.uid}");
                    }on FirebaseAuthException catch(e){
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    }catch(e){
                      print("Error happened");
                    }
                  }
                },),
              ),
              SizedBox(height: 48,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(StringsManager.alreadyHaveAccount,style: Theme.of(context).textTheme.labelSmall,),
                  TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                      },
                      child: Text(StringsManager.login,style: Theme.of(context).textTheme.titleLarge,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
