
import '../widgets/snack_bar.dart';
import 'app_strings.dart';

bool validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if(!validateEmptyField(value!)){
    snackBarView(AppString.error, 'Please enter email');
    return false;
  } else if (!regex.hasMatch(value)) {
    snackBarView(AppString.error, 'Enter valid e-mail');
    return false;
  } else {
    return true;
  }
}

bool validateEmptyField(String value) {
  if (value.trim().toString().isEmpty) {
    return false;
  } else {
    return true;
  }
}

bool validatePassword(String? value) {
  if ((value?.length ?? 0) < 8 || (value?.length ?? 0) > 32) {
    snackBarView(AppString.error, 'Password must be more than 8 characters');
    return false;
  } else if (!isPasswordCompliant(value ?? '')) {
    snackBarView(AppString.error, 'Must contain combination of uppercase, lowercase, numeric & special characters');
    return false;
  } else {
    return true;
  }
}

bool isPasswordCompliant(String password, [int minLength = 8]) {
  if (password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(RegExp(r'[a-z]'));
  bool hasSpecialCharacters = password.contains(RegExp(r'[@#$&*(),.?":{}|<>]'));
  bool hasMinLength = password.length > minLength;

  return hasDigits &
  hasUppercase &
  hasLowercase &
  hasSpecialCharacters &
  hasMinLength;
}