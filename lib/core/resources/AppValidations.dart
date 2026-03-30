import 'AppConstants.dart';

class AppValidations {

  static String? validateEmail(String? value){
    if(value==null || value.isEmpty){
      return "Email is required";
    }
    if(!RegExp(AppConstants.emailRegex).hasMatch(value)){
      return "Invalid Email";
    }
    return null;
  }
  static String? validatePassword(String? value){
    if(value==null || value.isEmpty){
      return "Password is required";
    }
    if(value.length<8){
      return "Weak Password";
    }
    return null;
  }

  static String? validateName(String? value){
    if(value==null || value.isEmpty){
      return "Your name is required";
    }

    return null;
  }
}