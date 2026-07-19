import 'package:intl/intl.dart';

abstract final class AppDateTimeFormatter {
  static DateTime? tryParseApiDateTime(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) return null;
    return DateTime.tryParse(normalized);
  }

  static String formatDateTime(DateTime value, {required String locale}) {
    return DateFormat.yMMMd(locale).add_jm().format(value);
  }

  static String formatDate(DateTime value, {required String locale}) {
    return DateFormat.yMMMd(locale).format(value);
  }

  static String formatTime(DateTime value, {required String locale}) {
    return DateFormat.jm(locale).format(value);
  }
}
