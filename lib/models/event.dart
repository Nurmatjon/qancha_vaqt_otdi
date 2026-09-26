class Event {
  final String title;
  final DateTime dateTime;
  final String description;

  Event({
    required this.title,
    required this.dateTime,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dateTime': dateTime.toIso8601String(),
      'description': description,
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      description: json['description'] as String? ?? '',
    );
  }
}