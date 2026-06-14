import 'package:flutter_test/flutter_test.dart';
import 'package:scolair_teacher/app/app.dart';
import 'package:scolair_teacher/core/di/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('shows localized home title', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await setupDependencyInjection();
    await tester.pumpWidget(const App());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Scolair Home'), findsOneWidget);
  });
}
