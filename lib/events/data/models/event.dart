part of 'models.dart';

class Event extends Option {
  const Event({
    required this.id,
    required this.title,
    required this.image,
    required this.date,
    required this.category,
    required this.city,
    required this.country,
    required this.createdAt,
    required this.location,
    required this.price,
    required this.startTime,
  });

  final String id;
  final String title;
  final String image;
  final DateTime date;
  final String category;
  final int price;
  final DateTime startTime;
  final String city;
  final String country;
  final LatLng location;
  final DateTime createdAt;

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      image: json['image'] as String? ?? '',
      date: json['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000)
          : DateTime.now(),
      category: json['category'] as String? ?? '',
      city: json['city'] as String? ?? '',
      country: json['country'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      location: LatLng(
        latitude: double.parse(json['location'][0] as String),
        longitude: double.parse(json['location'][1] as String),
      ),
      price: json['price'] as int? ?? 0,
      startTime: DateTime.now(),
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        image,
        date,
        category,
        price,
        startTime,
        city,
        country,
        location,
        createdAt,
      ];
}
