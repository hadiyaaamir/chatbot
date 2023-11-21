part of 'models.dart';

abstract class ApiObject extends Equatable {
  const ApiObject();

  factory ApiObject.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

class EventObject extends ApiObject {
  const EventObject({
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

  factory EventObject.fromJson(Map<String, dynamic> json) {
    return EventObject(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      image: json['image'] as String? ?? '',
      date: DateTime.now(),
      category: json['category'] as String? ?? '',
      city: json['city'] as String? ?? '',
      country: json['country'] as String? ?? '',
      createdAt: DateTime.now(),
      location: LatLng(),
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
