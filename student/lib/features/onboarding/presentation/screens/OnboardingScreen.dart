import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../../core/storage/app_shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  final AppSharedPreferences preferences;

  const OnboardingScreen({
    super.key,
    required this.preferences,
  });

  Future<void> _finish(BuildContext context) async {
    await preferences.setFirstTime(false);

    debugPrint(
      "isFirstTime after save = ${preferences.isFirstTime}",
    );

    Navigator.pushReplacementNamed(
      context,
      '/home',
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white54,

      pages: [
        PageViewModel(
          title: "Welcome",
          body: "Welcome to Scolair",
          image: const Icon(
            Icons.school,
            size: 150,
            color: Colors.white,
          ),
        ),

        PageViewModel(
          title: "Learn",
          body: "Track your educational journey",
          image: const Icon(
            Icons.menu_book,
            size: 150,
            color: Colors.white,
          ),
        ),

        PageViewModel(
          title: "Start",
          body: "Let's begin",
          image: const Icon(
            Icons.rocket_launch,
            size: 150,
            color: Colors.white,
          ),
        ),
      ],

      done: const Text(
        "Done",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),

      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),

      skip: const Text(
        "Skip",
        style: TextStyle(
          color: Colors.white,
        ),
      ),

      showSkipButton: true,

      onDone: () => _finish(context),

      onSkip: () => _finish(context),

      dotsDecorator: const DotsDecorator(
        activeColor: Colors.white,
      ),
    );
  }
}