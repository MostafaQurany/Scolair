import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../cubit/home_cubit.dart';
import '../widgets/home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({this.embedded = false, super.key});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TeacherHomeCubit>()..load(),
      child: HomeView(embedded: embedded),
    );
  }
}
