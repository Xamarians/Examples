import 'package:flutter_mvvm_demo/models/modelRegex.dart';
import 'package:flutter_mvvm_demo/resources/strings.dart';

class LoginHelper {
 // static ModelRegex regexEmail = Strings.getEmailRegex(0);
//  static ModelRegex regexPassword = Strings.getPasswordRegex(0);

  static String validateEmail(String value) {
    ModelRegex regexEmail = Strings.getEmailRegex(0);
    if (value == null || value.isEmpty) {
      return "Email can not be left blank";
    } else if (!RegExp(regexEmail.regex).hasMatch(value)) {
      return regexEmail.errorMessage;
    } else {
      return null;
    }
  }

  static String validatePassword(String value) {
    ModelRegex regexPassword = Strings.getPasswordRegex(8);
    print(regexPassword); 
    if (value == null || value.isEmpty) {
      return "Password can not be left blank";
    } else if (!RegExp(regexPassword.regex).hasMatch(value)) {
      return regexPassword.errorMessage;
    } else {
      return null;
    }
  }
}
