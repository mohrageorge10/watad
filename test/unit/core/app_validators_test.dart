import 'package:flutter_test/flutter_test.dart';
import 'package:watad/core/utils/app_validators.dart';

void main() {
  group('AppValidators Tests', () {
    group('validateEmail', () {
      test('returns error when email is null or empty', () {
        expect(AppValidators.validateEmail(null), 'Email is required');
        expect(AppValidators.validateEmail(''), 'Email is required');
        expect(AppValidators.validateEmail('   '), 'Email is required');
      });

      test('returns error when email format is invalid', () {
        expect(
          AppValidators.validateEmail('notanemail'),
          'Please enter a valid email address',
        );
        expect(
          AppValidators.validateEmail('user@'),
          'Please enter a valid email address',
        );
        expect(
          AppValidators.validateEmail('@example.com'),
          'Please enter a valid email address',
        );
      });

      test('returns null when email format is valid', () {
        expect(AppValidators.validateEmail('user@example.com'), isNull);
        expect(AppValidators.validateEmail('mohra.george@watad.org'), isNull);
      });
    });

    group('validatePassword', () {
      test('returns error when password is null or empty', () {
        expect(AppValidators.validatePassword(null), 'Password is required');
        expect(AppValidators.validatePassword(''), 'Password is required');
      });

      test('returns error when password is less than 8 characters', () {
        expect(
          AppValidators.validatePassword('1234567'),
          'Password must be at least 8 characters',
        );
      });

      test('returns null when password is 8 characters or more', () {
        expect(AppValidators.validatePassword('12345678'), isNull);
        expect(AppValidators.validatePassword('StrongP@ssword123'), isNull);
      });
    });

    group('validateConfirmPassword', () {
      test('returns error when confirm password is null or empty', () {
        expect(
          AppValidators.validateConfirmPassword(null, 'Pass123'),
          'Please confirm your password',
        );
        expect(
          AppValidators.validateConfirmPassword('', 'Pass123'),
          'Please confirm your password',
        );
      });

      test('returns error when passwords do not match', () {
        expect(
          AppValidators.validateConfirmPassword('Pass456', 'Pass123'),
          'Passwords do not match',
        );
      });

      test('returns null when passwords match', () {
        expect(
          AppValidators.validateConfirmPassword('Pass123', 'Pass123'),
          isNull,
        );
      });
    });

    group('validateName', () {
      test('returns error when name is null or empty', () {
        expect(AppValidators.validateName(null), 'Name is required');
        expect(AppValidators.validateName(''), 'Name is required');
      });

      test('returns error when name is shorter than 3 characters', () {
        expect(
          AppValidators.validateName('Mo'),
          'Name must be at least 3 characters',
        );
      });

      test('returns null when name is valid', () {
        expect(AppValidators.validateName('Mohra'), isNull);
        expect(AppValidators.validateName('George Watad'), isNull);
      });
    });

    group('validatePhone', () {
      test('returns error when phone number is null or empty', () {
        expect(AppValidators.validatePhone(null), 'Phone number is required');
        expect(AppValidators.validatePhone(''), 'Phone number is required');
      });

      test('returns error when phone number is less than 11 digits', () {
        expect(
          AppValidators.validatePhone('0101234567'),
          'Please enter a valid phone number',
        );
      });

      test('returns null when phone number is 11 digits or more', () {
        expect(AppValidators.validatePhone('01012345678'), isNull);
      });
    });
  });
}
