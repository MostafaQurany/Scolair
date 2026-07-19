import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'app_cached_network_image.dart';

class AppUserAvatar extends StatelessWidget {
  const AppUserAvatar({
    required this.imageUrl,
    required this.displayName,
    required this.userId,
    this.radius = 20,
    super.key,
  });

  final String? imageUrl;
  final String? displayName;
  final String? userId;
  final double radius;

  // A curated palette of theme-safe, high-contrast, visually pleasing colors
  static const List<Color> _avatarColors = [
    Color(0xFF1E3A8A), // Dark Blue
    Color(0xFF0D9488), // Teal
    Color(0xFF0284C7), // Sky Blue
    Color(0xFF7C3AED), // Violet
    Color(0xFFDB2777), // Pink
    Color(0xFFE11D48), // Rose
    Color(0xFFD97706), // Amber
    Color(0xFF059669), // Green
    Color(0xFF4F46E5), // Indigo
    Color(0xFF2563EB), // Blue
  ];

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;
    final size = radius * 2;

    if (hasImage) {
      return AppCachedNetworkImage(
        imageUrl: imageUrl,
        width: size.r,
        height: size.r,
        fit: BoxFit.cover,
        borderRadius: BorderRadius.circular(radius.r),
        errorWidget: _buildInitialsAvatar(context),
      );
    }

    return _buildInitialsAvatar(context);
  }

  Widget _buildInitialsAvatar(BuildContext context) {
    final initials = _getInitials(displayName);
    final color = _getStableColor(userId ?? displayName ?? '');

    return Container(
      width: (radius * 2).r,
      height: (radius * 2).r,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
            fontSize: (radius * 0.8).sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return '?';

    final cleaned = name.trim();
    final words = cleaned.split(RegExp(r'\s+'));

    if (words.length == 1) {
      final firstWord = words.first;
      return firstWord.isNotEmpty ? firstWord[0].toUpperCase() : '?';
    } else {
      final firstChar = words.first.isNotEmpty ? words.first[0] : '';
      final lastChar = words.last.isNotEmpty ? words.last[0] : '';
      return (firstChar + lastChar).toUpperCase();
    }
  }

  Color _getStableColor(String seed) {
    if (seed.isEmpty) return _avatarColors.first;

    // Deterministic hash function
    int hash = 0;
    for (int i = 0; i < seed.length; i++) {
      hash = seed.codeUnitAt(i) + ((hash << 5) - hash);
    }

    final index = hash.abs() % _avatarColors.length;
    return _avatarColors[index];
  }
}
