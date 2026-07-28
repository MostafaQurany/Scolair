import '../../domain/entities/homework_detail.dart';
import '../cubit/details/homework_details_cubit.dart';

class HomeworkQuestionsSliderScreenArgs {
  const HomeworkQuestionsSliderScreenArgs({
    required this.cubit,
    required this.homework,
  });

  final HomeworkDetailsCubit cubit;
  final HomeworkDetail homework;
}
