import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AppCachedNetworkImage extends StatelessWidget {
  const AppCachedNetworkImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    super.key,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;

    if (url == null || url.trim().isEmpty) {
      return _fallback(context);
    }

    Widget image = CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, _) => placeholder ?? _shimmerPlaceholder(context),
      errorWidget: (_, _, _) => errorWidget ?? _fallback(context),
    );

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }

  Widget _shimmerPlaceholder(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
    );
  }

  Widget _fallback(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child:
          errorWidget ??
          Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 32.r,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
    );
  }
}
