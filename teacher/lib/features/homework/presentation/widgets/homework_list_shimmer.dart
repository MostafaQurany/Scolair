import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeworkListShimmer extends StatelessWidget {
  const HomeworkListShimmer({required this.useGrid, super.key});

  final bool useGrid;

  @override
  Widget build(BuildContext context) {
    final cards = List.generate(6, (_) => const _HomeworkSkeletonCard());
    return Skeletonizer.sliver(
      child: useGrid
          ? SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 520.w,
                mainAxisExtent: 390.h,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
              ),
              delegate: SliverChildListDelegate(cards),
            )
          : SliverList.separated(
              itemCount: cards.length,
              itemBuilder: (_, index) => cards[index],
              separatorBuilder: (_, _) => SizedBox(height: 14.h),
            ),
    );
  }
}

class _HomeworkSkeletonCard extends StatelessWidget {
  const _HomeworkSkeletonCard();

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    clipBehavior: Clip.antiAlias,
    child: Padding(
      padding: EdgeInsetsDirectional.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(
            alignment: AlignmentDirectional.centerStart,
            child: Icon(Icons.more_vert),
          ),
          SizedBox(height: 8.h),
          Text(
            'Homework title placeholder',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8.h),
          Text(
            'Homework instruction preview placeholder text',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 14.h),
          const _SkeletonMetadataRow(
            icon: Icons.event_outlined,
            label: 'Due Jul 31, 11:59 PM',
          ),
          SizedBox(height: 6.h),
          const _SkeletonMetadataRow(
            icon: Icons.grade_outlined,
            label: '100 points',
          ),
          SizedBox(height: 6.h),
          const _SkeletonMetadataRow(
            icon: Icons.schedule_outlined,
            label: 'Late submissions allowed',
          ),
          SizedBox(height: 16.h),
          const Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Chip(label: Text('Course name')),
          ),
        ],
      ),
    ),
  );
}

class _SkeletonMetadataRow extends StatelessWidget {
  const _SkeletonMetadataRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: 18.r),
      SizedBox(width: 8.w),
      Expanded(child: Text(label)),
    ],
  );
}
