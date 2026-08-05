import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class DelimiterBlockWidget extends StatelessWidget {
  const DelimiterBlockWidget({super.key});

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Center(
        child: Text(
          '•  •  •',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.outline,
            letterSpacing: 8,
          ),
        ),
      ),
    );
}
