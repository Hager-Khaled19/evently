import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/events/event_details_screen.dart';
import '../../models/event_model.dart';
import '../providers/events_provider.dart';
import '../theme/app_colors.dart';
import '../utils/app_strings.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor =
    isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;
    final stroke =
    isDark ? AppColors.strokeDarkColor : AppColors.strokeWhiteColor;
    final provider = Provider.of<EventsProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EventDetailsScreen(event: event),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkBgColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: stroke),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 343 / 150,
                    child: Image.asset(
                      event.imageFor(isDark),
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                PositionedDirectional(
                  top: 8,
                  start: 8,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkInputColor
                          : AppColors.lightBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${event.date.day} ${s.months[event.date.month - 1]}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: mainColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color:
                isDark ? AppColors.darkInputColor : AppColors.lightBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => provider.toggleFavourite(event),
                    child: Icon(
                      event.isFavourite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: mainColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}