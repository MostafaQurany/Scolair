import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../../../../core/localization/localization_extension.dart';

class UnsupportedBlockWidget extends StatelessWidget {
  const UnsupportedBlockWidget({
    required this.type,
    required this.data,
    super.key,
  });

  final String type;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber.shade200),
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        '${context.l10n.unsupportedBlockType} "$type": $data',
        style: TextStyle(color: Colors.amber.shade900, fontSize: 12.sp),
      ),
    );
  }
}
