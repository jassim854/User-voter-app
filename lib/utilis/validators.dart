

class Validators {
  static String? validateField(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return "required";
    }
    return null;
  }



  static String? validateEmail(value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern as String);

    if (value.isEmpty) {
      return "required";
    } else if (!regex.hasMatch(value)) {
      return "incorrect_email_entered";
    }
    return null;
  }

  static String? validatePassword(
    value,
  ) {
    if (value.isEmpty) {
      return "required";
    } else if (value.length < 8) {
      return "min_8_char_required";
    }
    return null;
  }


  static String? validatePhoneNumber(
     value,
  ) {
    Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = RegExp(pattern as String);
    if (value.isEmpty) {
      return "required";
    } else if (!regex.hasMatch(value)) {
      return "Incorrect phone number entered";
    }
    return null;
  }
}
