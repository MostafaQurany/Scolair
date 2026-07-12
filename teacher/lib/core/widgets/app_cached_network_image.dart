import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:scolair_teacher/core/network/api_endpoints.dart';
import 'package:scolair_teacher/core/storage/app_secure_storage.dart';

class AppCachedNetworkImage extends StatefulWidget {
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
  State<AppCachedNetworkImage> createState() => _AppCachedNetworkImageState();
}

class _AppCachedNetworkImageState extends State<AppCachedNetworkImage> {
  String? token;
  final appSecureStorage = AppSecureStorage();
  @override
  void initState() {
    super.initState();
    appSecureStorage.readAccessToken().then((value) {
      setState(() {
        token = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var url = widget.imageUrl;

    if (url != null && url.isNotEmpty && !url.contains('http')) {
      url = ApiEndpoints.baseUrl + url;
    }
    if (url == null || url.trim().isEmpty) {
      return _fallback(context);
    }

    Widget image = CachedNetworkImage(
      imageUrl: url,
      httpHeaders: {'Authorization': 'Bearer $token'},
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      placeholder: (_, _) => widget.placeholder ?? _shimmerPlaceholder(context),
      errorWidget: (_, _, _) => widget.errorWidget ?? _fallback(context),
    );

    if (widget.borderRadius != null) {
      image = ClipRRect(borderRadius: widget.borderRadius!, child: image);
    }

    return image;
  }

  Widget _shimmerPlaceholder(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
    );
  }

  Widget _fallback(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child:
          widget.errorWidget ??
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
