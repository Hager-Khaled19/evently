import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/events_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/event_card.dart';

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final provider = Provider.of<EventsProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor =
    isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;
    final events = provider.favouriteEvents;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            TextField(
              onChanged: provider.setSearch,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? AppColors.whiteColor : AppColors.blackColor,
              ),
              decoration: InputDecoration(
                hintText: s.searchEvent,
                hintStyle: TextStyle(
                  fontSize: 12,
                  color:
                  isDark ? AppColors.whiteDarkColor : AppColors.greyColor,
                ),
                filled: true,
                fillColor:
                isDark ? AppColors.darkInputColor : AppColors.whiteColor,
                suffixIcon: Icon(Icons.search, color: mainColor),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark
                        ? AppColors.strokeDarkColor
                        : AppColors.strokeWhiteColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: mainColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: events.isEmpty
                  ? Center(child: Text(s.noFavourites))
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