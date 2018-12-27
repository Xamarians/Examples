import 'package:flutter_mvvm_demo/models/modelRegex.dart';

class Strings {
  ///Login Page
  static String loginPageTitle = "Login Demo";

  ///Password validation set
  static ModelRegex getEmailRegex(int value) {
    var regex = r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    var error = "Please enter a valid email";
    return new ModelRegex(errorMessage: error, regex: regex);
  }

  /// Email validation set
  static ModelRegex getPasswordRegex(int value) {
    ModelRegex model = new ModelRegex();

    switch (value) {
      //For the case when we require only minimum number of "7" characters in password.
      case 0:
        model.regex = r"^.{7}$";
        model.errorMessage = "The password must be atleast of 7 characters";
        break;
      //For the case when we require both minimum "7" and maximum "10" number of characters in a password.
      case 1:
        model.regex = r"^.{7,10}$";
        model.errorMessage =
            "The password length must be between 7 and 10 characters";
        break;

      //For the case when we reqiure one Uppercase character.
      case 2:
        // model.regex = r"^(?=.*\\d)(?=.*[A-Z]).{4}$";
        // model.errorMessage =
        //     "The password must contain atleast one Upper case caracter";
        break;
      //For the case when we require one special character.
      case 3:
        // model.regex =
        //     r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})";
        // model.errorMessage =
        //     "The password must contain atleast one special caracter";
        break;
      //For the case when we require one number
      case 4:
        model.regex = r"^(?=.*\d)$";
        model.errorMessage =
            "The password must contain atleast one numeric caracter";
        break;
      //For the case when we require One Upper case and minimum characters
      case 5:
        model.regex = r"^(?=.*\\d)(?=.*[A-Z]).{7}$";
        model.errorMessage =
            "The password must contain atleast one Upper case caracter";
        break;

      //For the case when we require One Upper case, one Lower case and minimum and maximum characters
      case 6:
        model.regex = r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).{7,10}$";
        model.errorMessage =
            "The password must contain atleast one Upper case caracter";
        break;
      //For the case when we require one special and one number
      case 7:
        // model.regex =
        //     r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})";
        // model.errorMessage =
        //     "The password must contain atleast one numeric character and one special caracter";
        break;
      //For the case when we require one special one numeric and one small and one caps
      case 8:
        model.regex =
            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{7,})";
        model.errorMessage =
            "The password must contain atleast 1 lower case, 1 upper case, 1 numeric character and one special caracter";
        break;
    }
    return model;
  }
}
