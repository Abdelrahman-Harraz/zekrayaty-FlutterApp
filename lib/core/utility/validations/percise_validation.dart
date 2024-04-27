import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'package:zekrayaty_app/core/utility/validations/Utility.dart';

class PreciseValidate extends GetxController {
  // Observable variables for validation messages
  final RxString nameError = RxString('');
  final RxString nickNameError = RxString('');
  final RxString nationalityError = RxString('');
  final RxString fieldError = RxString('');
  final RxString loginPasswordError = RxString('');
  final RxString complexPasswordError = RxString('');
  final RxString emailError = RxString('');
  final RxString birthDateError = RxString('');
  final RxString pincodeError = RxString('');
  final RxString passwordError = RxString('');

  // Validate if a value is required and not empty
  String? required(String value,
      {bool isRequired = true, String message = "This field cannot be empty"}) {
    if (isRequired && Utility.isNullOrEmpty(value)) {
      return message;
    } else {
      return null;
    }
  }

  // Validate a name field
  String? name(String name) {
    if (name.isEmpty) {
      return "Name can't be empty";
    }
    if (name.length < 2) {
      return "Short name";
    }
    return null;
  }

  // Validate a nickname field
  String? nickName(String nickName) {
    if (nickName.isEmpty) {
      return "Nickname can't be empty";
    }

    return null;
  }

  // Validate a nationality field
  String? nationality(String nationality) {
    if (nationality.isEmpty) {
      return "Nationality can't be empty";
    }

    return null;
  }

  // Validate a general field
  String? field(String val) {
    if (val.isEmpty) {
      return "Field can't be empty";
    }
    if (val.length < 2) {
      return "Short value";
    }
    return null;
  }

  // Validate a login password
  String? loginPassword(String value,
      {bool isRequired = true, String message = "Password"}) {
    if (isRequired && Utility.isNullOrEmpty(value)) {
      return "Please enter your password";
    } else if (value.length < 6) {
      return 'Enter a password with length at least 6';
    } else {
      return null;
    }
  }

  // Validate a complex password
  String? complexPassword(String password,
      {bool isRequired = true, String message = "Password can't be empty"}) {
    if (isRequired && Utility.isNullOrEmpty(password)) {
      return message;
    }
    if (!RegExp(r'^(?=.*[a-z])').hasMatch(password)) {
      return "Password must contain at least one lowercase letter";
    }
    if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(password)) {
      return "Password must contain at least one uppercase letter";
    }
    if (!RegExp('^.{5,15}').hasMatch(password)) {
      return "Password length must be between 5 and 15 characters";
    } else {
      return null;
    }
  }

  // Validate an email field
  String? email(
    String value, {
    bool isRequired = true,
    String message = "Email has incorrect format",
    String msgIfRequired = 'Email cannot be empty',
  }) {
    if (EmailValidator.validate(value)) {
      return null;
    } else if (isRequired && Utility.isNullOrEmpty(value)) {
      return msgIfRequired;
    } else {
      return "Wrong Email Format";
    }
  }

  // Validate a birth date field
  String? birthDate(
    DateTime value, {
    bool isRequired = true,
    String message = "Please select your birth date",
  }) {
    if (value.year == DateTime.now().year) {
      return "";
    }
    return null;
  }

  // Validate a pin code field
  String? pincode(String code, int length) {
    if (Utility.isNullOrEmpty(code)) {
      return "Verification code can't be empty";
    } else if (code.length < length) {
      return "Please enter the whole verification code";
    } else if (!isNumeric(code)) {
      return "Please enter the valid verification code";
    } else {
      return null;
    }
  }

  // Check if a string is numeric
  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) == null ? false : true;
  }

  // Validate an email field reactively
  void validateEmail(String value) {
    emailError.value = email(value) ?? '';
  }

  // Validate a password field reactively
  void validatePassword(String value) {
    loginPasswordError.value = loginPassword(value) ?? '';
  }

  // Check if a phone number is a valid Egyptian phone number
  bool isEgyptianPhoneNumber(String phone) {
    return isNumeric(phone) &&
        phone.length == 11 &&
        phone.startsWith(RegExp(r'(011|012|010)'));
  }

  void validateNationality(String value) {
    nationalityError.value = nationality(value) ?? '';
  }

  void validateNickName(String value) {
    nickNameError.value = nickName(value) ?? '';
  }
}
