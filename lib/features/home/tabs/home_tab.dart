import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/app_settings_provider.dart';
import '../../../core/providers/events_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/event_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  static const List<Map<String, dynamic>> _categories = [
    {'name': 'All', 'icon': Icons.grid_view_rounded},
    {'name': 'Sport', 'icon': Icons.directions_bike},
    {'name': 'Birthday', 'icon': Icons.cake_outlined},
    {'name': 'Meeting', 'icon': Icons.groups_outlined},
    {'name': 'Exhibition', 'icon': Icons.museum_outlined},
    {'name': 'Book Club', 'icon': Icons.menu_book_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final provider = Provider.of<EventsProvider>(context);
    final settings = Provider.of<AppSettingsProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor =
    isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;
    final events = provider.filteredEvents;

    final user = FirebaseAuth.instance.currentUser;
    final userName = (user?.displayName ?? '').isNotEmpty
        ? user!.displayName!
        : s.user;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.welcomeBack,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? AppColors.whiteDarkColor
                              : AppColors.greyColor,
                        ),
                      ),
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => settings.changeTheme(
                      isDark ? ThemeMode.light : ThemeMode.dark),
                  child: Icon(
                    isDark ? Icons.nightlight_outlined : Icons.wb_sunny_outlined,
                    color: mainColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => settings.changeLanguage(
                      settings.languageCode == 'en' ? 'ar' : 'en'),
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      settings.languageCode.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final name = _categories[index]['name'] as String;
                  final icon = _categories[index]['icon'] as IconData;
                  final selected = provider.selectedCategory == name;
                  final fg = selected
                      ? Colors.white
                      : (isDark ? AppColors.whiteColor : mainColor);
                  return GestureDetector(
                    onTap: () => provider.selectCategory(name),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected
                            ? mainColor
                            : (isDark
                            ? AppColors.darkInputColor
                            : AppColors.whiteColor),
                        border: Border.all(color: mainColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(icon, size: 18, color: fg),
                          const SizedBox(width: 6),
                          Text(
                            s.category(name),
                            style: TextStyle(fontSize: 13, color: fg),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: events.isEmpty
                  ? Center(child: Text(s.noEvents))
                  : ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) =>
                    EventCard(event: events[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}