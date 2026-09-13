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
  static String? validateConfirmPassword(
    String? value,
    String? originalPassword,
  ) {
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
    if (value.trim().length < 11) {
      return "Please enter a valid phone number";
    }
    return null;
  }

  // 6. Commercial Register validation (السجل التجاري)
  static String? validateCommercialRegister(
    String? value, {
    bool isRequired = false,
  }) {
    if (value == null || value.trim().isEmpty) {
      if (isRequired) return "Commercial Register number is required";
      return null;
    }
    final clean = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (clean.length < 5 || clean.length > 15) {
      return "Commercial Register must be between 5 and 15 digits";
    }
    return null;
  }

  // 7. Tax ID validation (الرقم الضريبي / البطاقة الضريبية - 9 أرقام)
  static String? validateTaxId(
    String? value, {
    bool isRequired = false,
  }) {
    if (value == null || value.trim().isEmpty) {
      if (isRequired) return "Tax ID is required";
      return null;
    }
    final clean = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (clean.length != 9) {
      return "Tax ID must be 9 digits (e.g. 123-456-789)";
    }
    return null;
  }

  // 8. Experience validation
  static String? validateExperience(
    String? value, {
    bool isRequired = true,
  }) {
    if (value == null || value.trim().isEmpty) {
      if (isRequired) return "Years of experience is required";
      return null;
    }
    final clean = value.trim().replaceAll('+', '');
    final num = int.tryParse(clean);
    if (num == null || num < 0 || num > 70) {
      return "Please enter a valid number of years (0 - 70)";
    }
    return null;
  }
}

