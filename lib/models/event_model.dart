import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/utils/app_assets.dart';

class EventModel {
  final String id;
  String title;
  String description;
  String category;
  DateTime date;
  bool isFavourite;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    this.isFavourite = false,
  });

  factory EventModel.fromMap(String id, Map<String, dynamic> map) {
    return EventModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? 'Book Club',
      date: (map['date'] as Timestamp).toDate(),
      isFavourite: map['isFavourite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'date': Timestamp.fromDate(date),
      'isFavourite': isFavourite,
    };
  }

  String imageFor(bool isDark) {
    switch (category) {
      case 'Birthday':
        return isDark ? AppAssets.birthdayDark : AppAssets.birthdayLight;
      case 'Book Club':
        return isDark ? AppAssets.bookClubDark : AppAssets.bookClubLight;
      case 'Exhibition':
        return isDark ? AppAssets.exhibitionDark : AppAssets.exhibitionLight;
      case 'Meeting':
        return isDark ? AppAssets.meetingDark : AppAssets.meetingLight;
      case 'Sport':
        return isDark ? AppAssets.sportDark : AppAssets.sportLight;
      default:
        return isDark ? AppAssets.meetingDark : AppAssets.meetingLight;
    }
  }
}