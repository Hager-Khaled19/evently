import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/app_settings_provider.dart';
import '../../../core/providers/events_provider.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_strings.dart';
import '../../auth/login_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final settings = Provider.of<AppSettingsProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor =
    isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;
    final cardColor = isDark ? AppColors.darkInputColor : AppColors.whiteColor;
    final textColor = isDark ? AppColors.whiteColor : AppColors.blackColor;
    final strokeColor =
    isDark ? AppColors.strokeDarkColor : AppColors.strokeWhiteColor;

    final user = FirebaseAuth.instance.currentUser;
    final userName = (user?.displayName ?? '').isNotEmpty
        ? user!.displayName!
        : s.user;
    final userEmail = user?.email ?? '';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Image.asset(AppAssets.routeProfileLogo, height: 90),
            const SizedBox(height: 12),
            Text(
              userName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              userEmail,
              style: TextStyle(
                fontSize: 11,
                color: isDark ? AppColors.whiteDarkColor : AppColors.greyColor,
              ),
            ),
            const SizedBox(height: 24),
            _item(
              color: cardColor,
              stroke: strokeColor,
              child: Row(
                children: [
                  Expanded(
                    child: Text(s.darkMode,
                        style: TextStyle(fontSize: 13, color: textColor)),
                  ),
                  Switch(
                    value: settings.themeMode == ThemeMode.dark,
                    activeThumbColor: Colors.white,
                    activeTrackColor: mainColor,
                    onChanged: (value) => settings.changeTheme(
                        value ? ThemeMode.dark : ThemeMode.light),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _item(
              color: cardColor,
              stroke: strokeColor,
              onTap: () => _showLanguageSheet(context, settings),
              child: Row(
                children: [
                  Expanded(
                    child: Text(s.language,
                        style: TextStyle(fontSize: 13, color: textColor)),
                  ),
                  Icon(Icons.chevron_right, color: mainColor),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _item(
              color: cardColor,
              stroke: strokeColor,
              onTap: () async {
                Provider.of<EventsProvider>(context, listen: false)
                    .stopListening();
                await AuthService().logout();
                if (!context.mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                );
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(s.logout,
                        style: TextStyle(fontSize: 13, color: textColor)),
                  ),
                  const Icon(Icons.logout, color: AppColors.redColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item({
    required Color color,
    required Color stroke,
    required Widget child,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: stroke),
        ),
        child: child,
      ),
    );
  }

  void _showLanguageSheet(BuildContext context, AppSettingsProvider settings) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor =
    isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('English',
                    style: TextStyle(
                        color: settings.languageCode == 'en'
                            ? mainColor
                            : null)),
                trailing: settings.languageCode == 'en'
                    ? Icon(Icons.check, color: mainColor)
                    : null,
                onTap: () {
                  settings.changeLanguage('en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('العربية',
                    style: TextStyle(
                        color: settings.languageCode == 'ar'
                            ? mainColor
                            : null)),
                trailing: settings.languageCode == 'ar'
                    ? Icon(Icons.check, color: mainColor)
                    : null,
                onTap: () {
                  settings.changeLanguage('ar');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}