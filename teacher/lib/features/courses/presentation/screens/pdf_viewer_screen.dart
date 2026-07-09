import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:pdfx/pdfx.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({required this.fileUrl, super.key});

  final String fileUrl;

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late final PdfController _controller;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = PdfController(document: _download());
  }

  Future<PdfDocument> _download() async {
    // getIt<Dio>() already has AuthInterceptor → adds Bearer token automatically
    final response = await getIt<Dio>().get<List<int>>(
      widget.fileUrl,
      options: Options(responseType: ResponseType.bytes),
    );
    return PdfDocument.openData(Uint8List.fromList(response.data!));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final fileName = widget.fileUrl.split('/').last;

    return Scaffold(
      appBar: AppBar(
        title: Text(fileName, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: _errorMessage != null
          ? Center(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48.r,
                      color: colorScheme.error,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      _errorMessage!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : PdfView(
              controller: _controller,
              scrollDirection: Axis.vertical,
              onDocumentError: (error) {
                if (mounted) {
                  setState(() => _errorMessage = context.l10n.authErrorGeneric);
                }
              },
            ),
    );
  }
}
