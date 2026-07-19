import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TeacherHomeSkeletonView extends StatelessWidget {
  const TeacherHomeSkeletonView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Skeletonizer(
        enabled: true,
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Row(
                children: [
                  Container(width: 24.r, height: 24.r, color: Colors.grey.shade300),
                  SizedBox(width: 8.w),
                  Container(width: 100.w, height: 20.h, color: Colors.grey.shade300),
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: CircleAvatar(
                    radius: 16.r,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 600.w),
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 22.r,
                            height: 22.r,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            width: 180.w,
                            height: 20.h,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 30.w),
                        child: Container(
                          width: 220.w,
                          height: 14.h,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 600.w),
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Container(
                    height: 54.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 600.w),
                  padding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
                  child: SizedBox(
                    height: 38.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 16.w,
                      ),
                      itemCount: 4,
                      separatorBuilder: (_, _) => SizedBox(width: 8.w),
                      itemBuilder: (_, _) => Container(
                        width: 90.w,
                        height: 38.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 600.w),
                    child: Card(
                      margin: EdgeInsetsDirectional.only(
                        bottom: 12.h,
                        start: 16.w,
                        end: 16.w,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(
                          color: colorScheme.outlineVariant.withValues(
                            alpha: 0.4,
                          ),
                          width: 1.r,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 18.r,
                                  backgroundColor: Colors.grey.shade300,
                                ),
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120.w,
                                      height: 14.h,
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(height: 4.h),
                                    Container(
                                      width: 80.w,
                                      height: 10.h,
                                      color: Colors.grey.shade300,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Container(
                              width: double.infinity,
                              height: 14.h,
                              color: Colors.grey.shade300,
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              width: double.infinity,
                              height: 14.h,
                              color: Colors.grey.shade300,
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              width: 200.w,
                              height: 14.h,
                              color: Colors.grey.shade300,
                            ),
                            SizedBox(height: 12.h),
                            if (index == 1) ...[
                              Container(
                                width: double.infinity,
                                height: 160.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              SizedBox(height: 12.h),
                            ],
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 32.h,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 32.h,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                Container(
                                  width: 32.w,
                                  height: 32.h,
                                  color: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }, childCount: 2),
            ),
          ],
        ),
      ),
    );
  }
}
