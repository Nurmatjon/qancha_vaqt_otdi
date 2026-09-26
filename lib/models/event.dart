import 'event_category.dart';

class Event {
  final String title;
  final DateTime dateTime;
  final String description;
  final EventCategory category;

  Event({
    required this.title,
    required this.dateTime,
    required this.description,
    this.category = EventCategory.general,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dateTime': dateTime.toIso8601String(),
      'description': description,
      'category': category.name,
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    final categoryName = json['category'] as String?;

    final category = EventCategory.values.firstWhere(
      (item) => item.name == categoryName,
      orElse: () => EventCategory.general,
    );

    return Event(
      title: json['title'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      description: json['description'] as String? ?? '',
      category: category,
    );
  }
}