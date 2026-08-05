import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../data/mock_classes_data.dart';
import '../../data/models/class_model.dart';
import '../widgets/attendance_section.dart';
import '../widgets/class_activity_section.dart';
import '../widgets/class_detail_header.dart';
import '../widgets/curriculum_section.dart';
import '../widgets/performance_section.dart';

/// Class Detail screen showing curriculum, activity, attendance and
/// performance for a single class (mock data for now).
class ClassDetailScreen extends StatelessWidget {
  const ClassDetailScreen({required this.classCode, super.key});

  final String classCode;

  @override
  Widget build(BuildContext context) {
    final classData = MockClassesData.getClassByCode(classCode);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ClassDetailHeader(
            classData: classData,
            onViewStudents: () {},
            onExamsQuizzes: () {},
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 100.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (classData.curriculum.isNotEmpty) ...[
                  CurriculumSection(items: classData.curriculum),
                  SizedBox(height: 28.h),
                ],
                if (classData.activities.isNotEmpty) ...[
                  ClassActivitySection(
                    activities: classData.activities,
                    onGradeNow: () {},
                  ),
                  SizedBox(height: 28.h),
                ],
                if (classData.attendance != null) ...[
                  AttendanceSection(
                    data: classData.attendance!,
                    onTakeAttendance: () {},
                  ),
                  SizedBox(height: 28.h),
                ],
                if (classData.performance != null)
                  PerformanceSection(data: classData.performance!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
