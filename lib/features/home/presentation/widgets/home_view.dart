import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/home_summary.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.appName)),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: Text(context.l10n.loading));
            }

            final errorMessage = state.errorMessage;
            if (errorMessage != null) {
              return _HomeError(message: errorMessage);
            }

            final summary = state.summary;
            if (summary == null) {
              return const SizedBox.shrink();
            }

            return _HomeContent(summary: summary);
          },
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.summary});

  final HomeSummary summary;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsetsDirectional.all(20.r),
      children: [
        Text(context.l10n.homeTitle, style: AppTextStyles.titleLarge),
        SizedBox(height: 8.h),
        Text(context.l10n.homeSubtitle, style: AppTextStyles.body),
        SizedBox(height: 24.h),
        _SummaryPanel(summary: summary),
      ],
    );
  }
}

class _SummaryPanel extends StatelessWidget {
  const _SummaryPanel({required this.summary});

  final HomeSummary summary;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsetsDirectional.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.homeSummaryTitle,
              style: AppTextStyles.titleMedium,
            ),
            SizedBox(height: 16.h),
            _SummaryRow(text: context.l10n.classCount(summary.classCount)),
            SizedBox(height: 10.h),
            _SummaryRow(
              text: context.l10n.assignmentCount(summary.assignmentCount),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8.r,
          height: 8.r,
          decoration: const BoxDecoration(
            color: AppColors.accent,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(child: Text(text, style: AppTextStyles.body)),
      ],
    );
  }
}

class _HomeError extends StatelessWidget {
  const _HomeError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsetsDirectional.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: AppTextStyles.body),
            SizedBox(height: 12.h),
            FilledButton(
              onPressed: context.read<HomeCubit>().loadSummary,
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
