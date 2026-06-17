import 'package:flutter_test/flutter_test.dart';
import 'package:scolair_parent/app/app.dart';
import 'package:scolair_parent/core/di/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('shows localized login title', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await setupDependencyInjection();
    await tester.pumpWidget(const App());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Welcome back'), findsOneWidget);
  });
}
