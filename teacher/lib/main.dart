import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'core/di/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencyInjection();

  final view = WidgetsBinding.instance.platformDispatcher.views.first;
  final size = view.physicalSize / view.devicePixelRatio;
  final isTablet = size.shortestSide >= 600;
  if (isTablet) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  runApp(const App());
}
