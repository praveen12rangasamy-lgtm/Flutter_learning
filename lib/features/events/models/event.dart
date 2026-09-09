class Event {
  final int id;
  final String title;
  final String description;
  final String location;
  final String date;
  final String time;
  final String category;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.time,
    required this.category,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No title',
      description: json['description'] ?? '',
      location: json['location'] ?? 'Unknown location',
      date: json['date'] ?? 'Unknown date',
      time: json['time'] ?? 'Unknown time',
      category: json['category'] ?? 'General',
    );
  }
}
