import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

class QuestionBankListShimmer extends StatelessWidget {
  const QuestionBankListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.sliver(
      enabled: true,
      child: SliverPadding(
        padding: EdgeInsets.all(16.r),
        sliver: SliverList.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            final colorScheme = Theme.of(context).colorScheme;
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24.r,
                    height: 24.r,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 70.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              width: 100.w,
                              height: 16.h,
                              color: colorScheme.surfaceContainerHighest,
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          width: double.infinity,
                          height: 14.h,
                          color: colorScheme.surfaceContainerHighest,
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          width: double.infinity,
                          height: 14.h,
                          color: colorScheme.surfaceContainerHighest,
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          width: 200.w,
                          height: 14.h,
                          color: colorScheme.surfaceContainerHighest,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
