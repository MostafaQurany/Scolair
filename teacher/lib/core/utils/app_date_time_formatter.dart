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

  static String formatRelativeTime(DateTime value, {required String locale}) {
    final now = DateTime.now();
    final difference = now.difference(value);
    final isAr = locale.startsWith('ar');

    if (difference.isNegative || difference.inSeconds < 60) {
      return isAr ? 'الآن' : 'Just now';
    }
    if (difference.inMinutes < 60) {
      final mins = difference.inMinutes;
      if (isAr) {
        if (mins == 1) return 'منذ دقيقة';
        if (mins == 2) return 'منذ دقيقتين';
        if (mins <= 10) return 'منذ $mins دقائق';
        return 'منذ $mins دقيقة';
      }
      return '$mins ${mins == 1 ? 'minute' : 'minutes'} ago';
    }
    if (difference.inHours < 24) {
      final hours = difference.inHours;
      if (isAr) {
        if (hours == 1) return 'منذ ساعة';
        if (hours == 2) return 'منذ ساعتين';
        if (hours <= 10) return 'منذ $hours ساعات';
        return 'منذ $hours ساعة';
      }
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    }
    if (difference.inDays == 1) {
      return isAr ? 'أمس' : 'Yesterday';
    }
    if (difference.inDays == 2) {
      return isAr ? 'قبل يومين' : '2 days ago';
    }
    if (difference.inDays < 7) {
      final days = difference.inDays;
      if (isAr) {
        if (days <= 10) return 'منذ $days أيام';
        return 'منذ $days يوماً';
      }
      return '$days days ago';
    }

    return formatDate(value, locale: locale);
  }
}
