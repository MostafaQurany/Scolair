import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/localization/localization_extension.dart';
import '../../../../../core/widgets/app_snack_bar.dart';

class CodeBlockWidget extends StatelessWidget {
  const CodeBlockWidget({
    required this.code,
    required this.language,
    super.key,
  });

  final String code;
  final String language;

  @override
  Widget build(BuildContext context) => DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  language.toUpperCase(),
                  style: GoogleFonts.dmSans(
                    color: Colors.greenAccent,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: code));
                    AppSnackBar.showSuccess(
                      context,
                      context.l10n.codeCopiedToClipboard,
                    );
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.copy, size: 14, color: Colors.white70),
                      SizedBox(width: 4.w),
                      Text(
                        'Copy', // Short common string doesn't need arb, but copy is general. Or we can localize if wanted.
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                code,
                style: GoogleFonts.dmSans(
                  color: const Color(0xFFD4D4D4),
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
}
