part of 'models.dart';

abstract class Option extends Equatable {
  const Option();

  factory Option.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

class EventOption extends Option {
  const EventOption({
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

  factory EventOption.fromJson(Map<String, dynamic> json) {
    return EventOption(
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

class TicketOption extends Option {
  const TicketOption({
    required this.id,
    required this.event,
    required this.username,
    required this.phone,
    required this.quantity,
    required this.paymentCompleted,
    required this.createdAt,
  });

  final String id;
  final EventOption event;
  final String username;
  final String phone;
  final int quantity;
  final bool paymentCompleted;
  final DateTime createdAt;

  factory TicketOption.fromJson(Map<String, dynamic> json) {
    return TicketOption(
      id: json['id'] as String? ?? '',
      event: EventOption.fromJson(json['event'] as Map<String, dynamic>? ?? {}),
      username: json['username'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
      paymentCompleted: json['paymentCompleted'] as bool? ?? false,
      createdAt: DateTime.now(),
    );
  }

  @override
  List<Object> get props => [
        id,
        event,
        username,
        phone,
        quantity,
        paymentCompleted,
        createdAt,
      ];
}
