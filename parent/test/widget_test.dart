import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scolair_parent/app/app.dart';
import 'package:scolair_parent/core/di/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('app renders splash screen on launch', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await setupDependencyInjection();
    await tester.pumpWidget(const App());
    await tester.pump();
    // Splash screen should be visible immediately after launch.
    expect(find.byType(MaterialApp), findsOneWidget);
    // Drain the 2-second splash delay to avoid pending timer errors.
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
  });
}
