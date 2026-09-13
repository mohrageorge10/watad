import 'package:intl/intl.dart';

class ChangeOrderFormatters {
  ChangeOrderFormatters._();

  static final NumberFormat _amountFormat = NumberFormat('#,###');
  static final DateFormat _dateFormat = DateFormat('MMM d, yyyy');

  static String costImpact(num value) {
    final sign = value >= 0 ? '+' : '-';
    return '${sign}EGP ${_amountFormat.format(value.abs())}';
  }

  static String daysImpact(int days) {
    final sign = days >= 0 ? '+' : '-';
    final absolute = days.abs();
    final unit = absolute == 1 ? 'Day' : 'Days';
    return '$sign$absolute $unit';
  }

  static String date(DateTime value) => _dateFormat.format(value);
}
