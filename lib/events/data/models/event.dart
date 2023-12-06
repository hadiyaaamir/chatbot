part of 'models.dart';

class Event extends Option {
  const Event({
    required this.id,
    required this.title,
    required this.image,
    required this.category,
    required this.city,
    required this.country,
    required this.createdAt,
    required this.location,
    required this.price,
    required this.startTime,
    required this.slots,
  });

  final String id;
  final String title;
  final String image;
  final String category;
  final int price;
  final DateTime startTime;
  final String city;
  final String country;
  final LatLng location;
  final DateTime createdAt;

  final List<EventSlot> slots;

  int get numberOfDays => slots.length;

  String get dayRange {
    if (slots.isEmpty) return '';

    DateTime smallestDate = slots.first.date;
    DateTime largestDate = slots.first.date;

    for (final slot in slots) {
      if (slot.date.isBefore(smallestDate)) {
        smallestDate = slot.date;
      } else if (slot.date.isAfter(largestDate)) {
        largestDate = slot.date;
      }
    }

    final formattedSmallest = DateFormat('dd MMM yyyy').format(smallestDate);
    final formattedLargest = DateFormat('dd MMM yyyy').format(largestDate);

    return '$formattedSmallest - $formattedLargest';
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      image: json['image'] as String? ?? '',
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
      slots: json['slots'] != null
          ? List<EventSlot>.from(
              (json['slots'] as List<dynamic>).map(
                (slotJson) => EventSlot.fromJson(slotJson),
              ),
            )
          : [],
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        image,
        category,
        price,
        startTime,
        city,
        country,
        location,
        createdAt,
        slots,
      ];
}
