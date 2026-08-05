import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeworkSubmissionsListShimmer extends StatelessWidget {
  const HomeworkSubmissionsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    
    return Skeletonizer(
      child: ListView.separated(
        padding: EdgeInsets.all(16.r),
        itemCount: 5,
        separatorBuilder: (_, _) => SizedBox(height: 12.h),
        itemBuilder: (context, index) => Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: BorderSide(color: colors.outlineVariant),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Student Name Placeholder',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
                        decoration: BoxDecoration(
                          color: colors.secondaryContainer,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'Submitted',
                          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '01 Jan 2024, 10:00 AM',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      Text(
                        '10.0',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Grade'),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
