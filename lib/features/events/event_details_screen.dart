import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/events_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_strings.dart';
import '../../models/event_model.dart';
import 'event_form_screen.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final provider = Provider.of<EventsProvider>(context);
    final current = provider.findById(event.id) ?? event;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor =
    isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;
    final textColor = isDark ? AppColors.whiteColor : AppColors.blackColor;
    final cardColor = isDark ? AppColors.darkInputColor : AppColors.whiteColor;
    final stroke =
    isDark ? AppColors.strokeDarkColor : AppColors.strokeWhiteColor;
    final subColor = isDark ? AppColors.whiteDarkColor : AppColors.greyColor;

    final d = current.date;
    final time = TimeOfDay(hour: d.hour, minute: d.minute).format(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              SizedBox(
                height: 36,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_ios_new,
                            size: 18, color: mainColor),
                      ),
                    ),
                    Text(
                      s.eventDetails,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      EventFormScreen(event: current),
                                ),
                              );
                            },
                            child: Icon(Icons.edit_outlined,
                                size: 20, color: mainColor),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              provider.deleteEvent(current);
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.delete_outline,
                                size: 20, color: AppColors.redColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 343 / 140,
                  child: Image.asset(
                    current.imageFor(isDark),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                current.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: stroke),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkBgColor
                            : AppColors.lightBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.calendar_month_outlined,
                          size: 20, color: mainColor),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${d.day} ${s.monthsFull[d.month - 1]}',
                          style: TextStyle(fontSize: 13, color: textColor),
                        ),
                        Text(
                          time,
                          style: TextStyle(fontSize: 11, color: subColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text(
                s.description,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: stroke),
                ),
                child: Text(
                  current.description,
                  style: TextStyle(fontSize: 12, height: 1.5, color: textColor),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}