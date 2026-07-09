import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../courses/presentation/screens/my_courses_screen.dart';
import '../../../homework/presentation/screens/homework_list_screen.dart';
import '../../../quiz/presentation/screens/quizzes_list_screen.dart';
import '../../data/mock_classes_data.dart';
import '../../data/models/class_model.dart';
import '../widgets/category_chips.dart';
import '../widgets/class_card.dart';
import '../widgets/class_search_bar.dart';
import 'class_detail_screen.dart';

/// Main "My Classes" screen showing the teacher's active classes with
/// search, category filters and a shortcut to their courses.
class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = MockClassesData.categories.first;
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ClassModel> get _filteredClasses {
    final isAll = _selectedCategory == MockClassesData.categories.first;
    final query = _query.trim().toLowerCase();

    return MockClassesData.classes.where((c) {
      final matchesCategory = isAll || c.category == _selectedCategory;
      final matchesQuery =
          query.isEmpty ||
          c.code.toLowerCase().contains(query) ||
          c.subject.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  void _openClass(ClassModel classData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClassDetailScreen(classCode: classData.code),
      ),
    );
  }

  void _openMyCourses() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MyCoursesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final classes = _filteredClasses;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: const _ClassesTopBar()),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Text(
                    context.l10n.classesTitle,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    context.l10n.classesSubtitle,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ClassSearchBar(
                    controller: _searchController,
                    hintText: context.l10n.classesSearchHint,
                    onChanged: (value) => setState(() => _query = value),
                  ),
                  SizedBox(height: 14.h),
                  CategoryChips(
                    categories: MockClassesData.categories,
                    selected: _selectedCategory,
                    onSelected: (value) =>
                        setState(() => _selectedCategory = value),
                  ),
                  SizedBox(height: 18.h),
                  _MyCoursesButton(onTap: _openMyCourses),
                  SizedBox(height: 18.h),
                  const _QuickActionsRow(),
                  SizedBox(height: 18.h),
                  if (classes.isEmpty)
                    _EmptyClasses()
                  else
                    ...classes.map(
                      (c) =>
                          ClassCard(classData: c, onTap: () => _openClass(c)),
                    ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClassesTopBar extends StatelessWidget {
  const _ClassesTopBar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 4.h),
      child: Row(
        children: [
          Image.asset('assets/images/logo_header.png', height: 30.h),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none_rounded,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(width: 4.w),
          CircleAvatar(
            radius: 18.r,
            backgroundColor: colorScheme.primaryContainer,
            child: Icon(
              Icons.person_outline,
              size: 20.r,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class _MyCoursesButton extends StatelessWidget {
  const _MyCoursesButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.primary, colorScheme.secondary],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Container(
                width: 44.r,
                height: 44.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.menu_book_rounded,
                  color: Colors.white,
                  size: 24.r,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  context.l10n.myCoursesButton,
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 22.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyClasses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: Column(
        children: [
          Icon(
            Icons.class_outlined,
            size: 56.r,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          SizedBox(height: 12.h),
          Text(
            context.l10n.classesTitle,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const QuizzesListScreen()),
            ),
            icon: const Icon(Icons.quiz_outlined),
            label: Text(context.l10n.homeQuizzesAction),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HomeworkListScreen()),
            ),
            icon: const Icon(Icons.assignment_outlined),
            label: Text(context.l10n.homeHomeworkAction),
          ),
        ),
      ],
    );
  }
}
