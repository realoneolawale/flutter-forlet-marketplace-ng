import 'package:flutter/material.dart';

class FormValidatorProvider extends ChangeNotifier {
  String? firstNameError;
  String? lastNameError;
  String? emailError;
  String? genderError;
  String? phoneNumberError;
  String? houseNumberError;
  String? streetNameError;
  String? areaNameError;
  String? stateIdError;
  String? lgaIdError;
  String? passwordError;
  String? confirmPasswordError;
  String? confirmPasswordCheck;

  void validateFirstName(String value) {
    if (value.isEmpty) {
      firstNameError = "First name can’t be empty";
    } else {
      firstNameError = null;
    }
    notifyListeners();
  }

  void validateLastName(String value) {
    if (value.isEmpty) {
      lastNameError = "Last name can’t be empty";
    } else {
      lastNameError = null;
    }
    notifyListeners();
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError = "Email can’t be empty";
    } else if (!RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(value)) {
      emailError = "Enter a valid email";
    } else {
      emailError = null;
    }
    notifyListeners();
  }

  void validatePhone(String value) {
    if (value.isEmpty) {
      phoneNumberError = "Phone number can’t be empty";
    } else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
      phoneNumberError = "Enter a valid 11 digit phone number";
    } else {
      phoneNumberError = null;
    }
    notifyListeners();
  }

  void validateHouseNumber(String value) {
    if (value.isEmpty) {
      houseNumberError = "House number can’t be empty";
    } else {
      houseNumberError = null;
    }
    notifyListeners();
  }

  void validateStreetName(String value) {
    if (value.isEmpty) {
      streetNameError = "Street name can’t be empty";
    } else {
      streetNameError = null;
    }
    notifyListeners();
  }

  void validateAreaName(String value) {
    if (value.isEmpty) {
      areaNameError = "Area name can’t be empty";
    } else {
      areaNameError = null;
    }
    notifyListeners();
  }

  void validateStateId(int value) {
    if (value <= 0) {
      stateIdError = "Select a state";
    } else {
      stateIdError = null;
    }
    notifyListeners();
  }

  void validateLgaId(int value) {
    if (value <= 0) {
      lgaIdError = "Select an L.G.A";
    } else {
      lgaIdError = null;
    }
    notifyListeners();
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError = "Password can't be empty";
    } else if (value.length < 6) {
      passwordError = "Password requires minimum of 6 characters";
    } else {
      confirmPasswordCheck = value;
      passwordError = null;
    }
    notifyListeners();
  }

  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      confirmPasswordError = "Confirm password can't be empty";
    } else if (value.length < 6) {
      confirmPasswordError = "Password requires minimum of 6 characters";
    } else if (value != confirmPasswordCheck) {
      confirmPasswordError = "Password does not match";
    } else {
      confirmPasswordError = null;
    }
    notifyListeners();
  }
}
