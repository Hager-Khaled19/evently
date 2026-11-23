import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_settings_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_assets.dart';
import '../../core/utils/app_strings.dart';
import 'intro_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettingsProvider>(context);
    final s = AppStrings.of(context);
    final isEnglish = settings.languageCode == 'en';
    final isLightTheme = settings.themeMode == ThemeMode.light;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor =
    isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Image.asset(
                  isDark ? AppAssets.logoDark : AppAssets.logoLight,
                  height: 28,
                ),
              ),
              Expanded(
                child: Center(
                  child: Image.asset(
                    isDark
                        ? AppAssets.onBoardingDark
                        : AppAssets.onBoardingLight,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                s.personalizeTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: mainColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                s.personalizeDesc,
                style: TextStyle(
                  fontSize: 14,
                  color:
                  isDark ? AppColors.whiteDarkColor : AppColors.greyColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(s.language,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: mainColor)),
                  Row(
                    children: [
                      _choice(s.english, isEnglish, mainColor,
                              () => settings.changeLanguage('en')),
                      const SizedBox(width: 8),
                      _choice(s.arabic, !isEnglish, mainColor,
                              () => settings.changeLanguage('ar')),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(s.theme,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: mainColor)),
                  Row(
                    children: [
                      _iconChoice(Icons.wb_sunny_outlined, isLightTheme,
                          mainColor,
                              () => settings.changeTheme(ThemeMode.light)),
                      const SizedBox(width: 8),
                      _iconChoice(Icons.nightlight_outlined, !isLightTheme,
                          mainColor,
                              () => settings.changeTheme(ThemeMode.dark)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const IntroScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(s.letsStart,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _choice(String text, bool selected, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? color : Colors.transparent,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: 13, color: selected ? Colors.white : color)),
      ),
    );
  }

  Widget _iconChoice(
      IconData icon, bool selected, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: selected ? color : Colors.transparent,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: selected ? Colors.white : color),
      ),
    );
  }
}