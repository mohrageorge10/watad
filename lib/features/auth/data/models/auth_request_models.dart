class LoginRequestModel {
  final String email;
  final String password;
  final bool rememberMe;

  const LoginRequestModel({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class RegisterRequestModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final int userType;

  const RegisterRequestModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'confirmPassword': confirmPassword,
        'userType': userType,
      };
}

class ConfirmEmailRequestModel {
  final String email;
  final String otp;

  const ConfirmEmailRequestModel({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'otp': otp,
      };
}

class ForgotPasswordRequestModel {
  final String email;

  const ForgotPasswordRequestModel({required this.email});

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}

class VerifyOtpRequestModel {
  final String email;
  final String otp;

  const VerifyOtpRequestModel({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'otp': otp,
      };
}

class ResetPasswordRequestModel {
  final String email;
  final String resetToken;
  final String newPassword;

  const ResetPasswordRequestModel({
    required this.email,
    required this.resetToken,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'resetToken': resetToken,
        'newPassword': newPassword,
      };
}

class GoogleLoginRequestModel {
  final String idToken;
  final int userType;

  const GoogleLoginRequestModel({
    required this.idToken,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
        'idToken': idToken,
        'userType': userType,
      };
}

class FacebookLoginRequestModel {
  final String accessToken;
  final int userType;

  const FacebookLoginRequestModel({
    required this.accessToken,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'userType': userType,
      };
}
