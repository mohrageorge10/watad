import 'package:flutter_test/flutter_test.dart';
import 'package:watad/core/errors/error_model.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/data/models/auth_response_model.dart';
import 'package:watad/features/auth/data/models/user_data_model.dart';

void main() {
  group('Auth Models Tests', () {
    group('AuthResponseModel & UserDataModel Parsing', () {
      test('correctly parses login response with standard token', () {
        final json = {
          'isSuccess': true,
          'statusCode': 200,
          'message': 'Login successful',
          'data': {
            'userId': 'usr-123',
            'fullName': 'Mohra George',
            'email': 'mohra@watad.org',
            'userType': 1,
            'role': 'Project Owner',
            'token': 'jwt_token_sample_123',
            'expirationDate': '2026-10-01T00:00:00Z',
          },
        };

        final response = AuthResponseModel.fromJson(json);

        expect(response.isSuccess, isTrue);
        expect(response.statusCode, 200);
        expect(response.message, 'Login successful');
        expect(response.data?.userId, 'usr-123');
        expect(response.data?.token, 'jwt_token_sample_123');
        expect(response.data?.role, 'Project Owner');
        expect(response.data?.userType, 1);

        final entity = response.toEntity();
        expect(entity.user?.token, 'jwt_token_sample_123');
        expect(entity.user?.fullName, 'Mohra George');
      });

      test('correctly parses verify-otp response with resetToken', () {
        final json = {
          'isSuccess': true,
          'statusCode': 200,
          'message': 'OTP verified successfully.',
          'data': {
            'resetToken': '50c4322b-b6c3-4d87-91f2-16dc04f0584d',
            'expirationDate': '2026-09-07T00:36:40Z',
          },
        };

        final response = AuthResponseModel.fromJson(json);

        expect(response.isSuccess, isTrue);
        expect(response.data?.token, '50c4322b-b6c3-4d87-91f2-16dc04f0584d');
        expect(response.toEntity().user?.token, '50c4322b-b6c3-4d87-91f2-16dc04f0584d');
      });

      test('handles non-map data (e.g. boolean data: true) gracefully', () {
        final json = {
          'isSuccess': true,
          'statusCode': 200,
          'message': 'OTP sent to email successfully!',
          'data': true,
        };

        final response = AuthResponseModel.fromJson(json);

        expect(response.isSuccess, isTrue);
        expect(response.data, isNull);
        expect(response.toEntity().user, isNull);
      });
    });

    group('AuthRequestModels Serialization', () {
      test('LoginRequestModel converts to Json correctly', () {
        final model = LoginRequestModel(
          email: 'test@watad.org',
          password: 'Password123',
          rememberMe: true,
        );

        final json = model.toJson();
        expect(json['email'], 'test@watad.org');
        expect(json['password'], 'Password123');
      });

      test('RegisterRequestModel converts to Json correctly', () {
        final model = RegisterRequestModel(
          fullName: 'Mohra',
          email: 'test@watad.org',
          phoneNumber: '01012345678',
          password: 'Password123',
          confirmPassword: 'Password123',
          userType: 2,
        );

        final json = model.toJson();
        expect(json['fullName'], 'Mohra');
        expect(json['email'], 'test@watad.org');
        expect(json['phoneNumber'], '01012345678');
        expect(json['userType'], 2);
      });

      test('VerifyOtpRequestModel converts to Json correctly', () {
        final model = VerifyOtpRequestModel(
          email: 'test@watad.org',
          otp: '123456',
        );

        final json = model.toJson();
        expect(json['email'], 'test@watad.org');
        expect(json['otp'], '123456');
      });

      test('ResetPasswordRequestModel converts to Json correctly', () {
        final model = ResetPasswordRequestModel(
          email: 'test@watad.org',
          resetToken: 'guid-reset-token',
          newPassword: 'NewPassword123',
        );

        final json = model.toJson();
        expect(json['email'], 'test@watad.org');
        expect(json['resetToken'], 'guid-reset-token');
        expect(json['newPassword'], 'NewPassword123');
      });

      test('GoogleLoginRequestModel converts to Json correctly', () {
        final model = GoogleLoginRequestModel(
          idToken: 'google_id_token_xyz',
          userType: 1,
        );

        final json = model.toJson();
        expect(json['idToken'], 'google_id_token_xyz');
        expect(json['userType'], 1);
      });

      test('FacebookLoginRequestModel converts to Json correctly', () {
        final model = FacebookLoginRequestModel(
          accessToken: 'facebook_access_token_xyz',
          userType: 3,
        );

        final json = model.toJson();
        expect(json['accessToken'], 'facebook_access_token_xyz');
        expect(json['userType'], 3);
      });
    });

    group('ErrorModel Parsing', () {
      test('correctly extracts ASP.NET Core ValidationProblemDetails errors map', () {
        final aspNetJson = {
          'type': 'https://tools.ietf.org/html/rfc7231#section-6.5.1',
          'title': 'One or more validation errors occurred.',
          'status': 400,
          'errors': {
            'Email': ['The Email field is required.'],
            'Password': ['Passwords must have at least one non alphanumeric character.'],
          },
        };

        final error = ErrorModel.fromJson(aspNetJson);
        expect(error.status, 400);
        expect(
          error.errorMessage,
          'The Email field is required., Passwords must have at least one non alphanumeric character.',
        );
      });

      test('falls back to title when errors map is empty', () {
        final aspNetJson = {
          'title': 'Resource not found or unauthorized',
          'status': 404,
        };

        final error = ErrorModel.fromJson(aspNetJson);
        expect(error.status, 404);
        expect(error.errorMessage, 'Resource not found or unauthorized');
      });
    });

    group('UserDataModel Role/UserType Mapping', () {
      test('maps string UserType "Owner" to 0 and "Contractor" to 2', () {
        final ownerJson = {
          'userType': 'Owner',
          'email': 'owner@watad.org',
        };
        final ownerModel = UserDataModel.fromJson(ownerJson);
        expect(ownerModel.userType, 0);
        expect(ownerModel.role, 'Project Owner');

        final contractorJson = {
          'userType': 'Contractor',
          'email': 'contractor@watad.org',
        };
        final contractorModel = UserDataModel.fromJson(contractorJson);
        expect(contractorModel.userType, 2);
        expect(contractorModel.role, 'Contractor');
      });
    });
  });
}
