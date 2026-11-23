import 'package:flutter/material.dart';
import '../../core/utils/app_assets.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  isDark ? AppAssets.logoDark : AppAssets.logoLight,
                  width: 220,
                ),
              ),
            ),
            Image.asset(AppAssets.logoRoute, height: 28),
            const SizedBox(height: 6),
            const Text(
              'Supervised by Mohamed Nabil',
              style: TextStyle(fontSize: 10),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}