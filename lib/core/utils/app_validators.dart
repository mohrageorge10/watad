import 'package:watad/core/constants/app_constants.dart';

class AppValidators {
  AppValidators._();

  // 1. Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    final RegExp emailRegExp = RegExp(AppConstants.emailRegex);
    if (!emailRegExp.hasMatch(value.trim())) {
      return "Please enter a valid email address";
    }
    return null;
  }

  // 2. Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < AppConstants.passwordMinLength) {
      return "Password must be at least ${AppConstants.passwordMinLength} characters";
    }
    return null;
  }

  // 3. Name validation
  static String? validateName(String? value, {String fieldName = "Name"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    if (value.trim().length < AppConstants.nameMinLength) {
      return "$fieldName must be at least ${AppConstants.nameMinLength} characters";
    }
    return null;
  }

  // 4. Confirm Password validation
  static String? validateConfirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != originalPassword) {
      return "Passwords do not match";
    }
    return null;
  }

  // 5. Phone validation
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }
    if (value.trim().length < 10) {
      return "Please enter a valid phone number";
    }
    return null;
  }
}
