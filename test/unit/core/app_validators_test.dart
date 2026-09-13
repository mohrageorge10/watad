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
        expect(AppValidators.validateEmail('engineer@watad.eg'), isNull);
        expect(AppValidators.validateEmail('user+test@company.co'), isNull);
        expect(AppValidators.validateEmail('dev@startup.io'), isNull);
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

    group('validateCommercialRegister', () {
      test('returns null when empty and not required', () {
        expect(AppValidators.validateCommercialRegister(null), isNull);
        expect(AppValidators.validateCommercialRegister(''), isNull);
        expect(AppValidators.validateCommercialRegister('   '), isNull);
      });

      test('returns error when empty and isRequired is true', () {
        expect(
          AppValidators.validateCommercialRegister(null, isRequired: true),
          'Commercial Register number is required',
        );
      });

      test('returns error when length is less than 5 digits', () {
        expect(
          AppValidators.validateCommercialRegister('123'),
          'Commercial Register must be between 5 and 15 digits',
        );
      });

      test('returns null when valid digits between 5 and 15', () {
        expect(AppValidators.validateCommercialRegister('12345'), isNull);
        expect(AppValidators.validateCommercialRegister('123456789'), isNull);
      });
    });

    group('validateTaxId', () {
      test('returns null when empty and not required', () {
        expect(AppValidators.validateTaxId(null), isNull);
        expect(AppValidators.validateTaxId(''), isNull);
        expect(AppValidators.validateTaxId('   '), isNull);
      });

      test('returns error when empty and isRequired is true', () {
        expect(
          AppValidators.validateTaxId(null, isRequired: true),
          'Tax ID is required',
        );
      });

      test('returns error when not exactly 9 digits', () {
        expect(
          AppValidators.validateTaxId('987'),
          'Tax ID must be 9 digits (e.g. 123-456-789)',
        );
        expect(
          AppValidators.validateTaxId('12345678'),
          'Tax ID must be 9 digits (e.g. 123-456-789)',
        );
      });

      test('returns null when exactly 9 digits (with or without dashes)', () {
        expect(AppValidators.validateTaxId('123456789'), isNull);
        expect(AppValidators.validateTaxId('987-654-321'), isNull);
      });
    });

    group('validateExperience', () {
      test('returns error when empty and required', () {
        expect(
          AppValidators.validateExperience(null),
          'Years of experience is required',
        );
        expect(
          AppValidators.validateExperience(''),
          'Years of experience is required',
        );
      });

      test('returns error when invalid number or out of bounds', () {
        expect(
          AppValidators.validateExperience('abc'),
          'Please enter a valid number of years (0 - 70)',
        );
        expect(
          AppValidators.validateExperience('99'),
          'Please enter a valid number of years (0 - 70)',
        );
      });

      test('returns null when valid experience', () {
        expect(AppValidators.validateExperience('0'), isNull);
        expect(AppValidators.validateExperience('5'), isNull);
        expect(AppValidators.validateExperience('10+'), isNull);
      });
    });
  });
}

