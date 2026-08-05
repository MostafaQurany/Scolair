import 'package:logger/logger.dart';

abstract final class AppLogger {
  static Logger? _logger;

  static void configure({required bool enabled}) {
    if (!enabled) {
      _logger = null;
      return;
    }
    _logger = Logger(
      printer: PrettyPrinter(
        
      ),
    );
  }

  static void debug(String message) => _logger?.d(message);

  static void info(String message) => _logger?.i(message);

  static void warning(String message) => _logger?.w(message);

  static void error(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger?.e(message, error: error, stackTrace: stackTrace);
}
