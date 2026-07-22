import '../../../../../core/network/api_endpoints.dart';

/// Resolves relative Frappe file URLs to absolute URLs using
/// the configured [ApiEndpoints.baseUrl].
///
/// Handles paths like:
/// - `/files/image.png`
/// - `/private/files/doc.pdf`
/// - `/assets/lms/images/card.jpeg`
/// - Already absolute `https://...` URLs
class FrappeFileUrlResolver {
  const FrappeFileUrlResolver._();

  static String resolve(String? url) {
    if (url == null || url.trim().isEmpty) return '';

    final trimmed = url.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }

    if (trimmed.contains('/private/') || trimmed.startsWith('private/')) {
      final uri = Uri.parse(
        '${ApiEndpoints.baseUrl}/api/method/lms.lms.doctype.course_lesson.course_lesson.serve_resource',
      );
      return uri.replace(queryParameters: {'file_url': trimmed}).toString();
    }

    final path = trimmed.startsWith('/') ? trimmed : '/$trimmed';
    return '${ApiEndpoints.baseUrl}$path';
  }
}
