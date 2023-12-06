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

  final List<ChatEventSlot> slots;

  int get numberOfDays => slots.length;

  String get dayRange {
    if (slots.isEmpty) return '';

    DateTime smallestDate = slots.first.date.dateSlot;
    DateTime largestDate = slots.first.date.dateSlot;

    for (final slot in slots) {
      if (slot.date.dateSlot.isBefore(smallestDate)) {
        smallestDate = slot.date.dateSlot;
      } else if (slot.date.dateSlot.isAfter(largestDate)) {
        largestDate = slot.date.dateSlot;
      }
    }

    return '${formatDate(smallestDate)} - ${formatDate(largestDate)}';
  }

  ChatEventSlot? get selectedSlot {
    final selectedSlots = slots.where((element) => element.date.isSelected);
    if (selectedSlots.isEmpty) return null;
    return selectedSlots.first;
  }

  ChatEventTimeSlot? get selectedTimeSlot {
    return selectedSlot?.selectedTimeSlot;
  }

  Event selectSlot({required ChatEventSlot eventSlot}) {
    return copyWith(
      slots: slots.map(
        (slot) {
          return slot.setDateSelected(slot == eventSlot);
        },
      ).toList(),
    );
  }

  Event selectTimeSlot({
    required ChatEventSlot eventSlot,
    required ChatEventTimeSlot timeSlot,
  }) {
    return copyWith(
      slots: slots.map((slot) {
        return slot == eventSlot ? slot.setTimeSelected(timeSlot) : slot;
      }).toList(),
    );
  }

  Event copyWith({
    String? id,
    String? title,
    String? image,
    String? category,
    int? price,
    DateTime? startTime,
    String? city,
    String? country,
    LatLng? location,
    DateTime? createdAt,
    List<ChatEventSlot>? slots,
  }) {
    return Event(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
        category: category ?? this.category,
        city: city ?? this.city,
        country: country ?? this.country,
        createdAt: createdAt ?? this.createdAt,
        location: location ?? this.location,
        price: price ?? this.price,
        startTime: startTime ?? this.startTime,
        slots: slots ?? this.slots);
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
          ? List<ChatEventSlot>.from(
              (json['slots'] as List<dynamic>).map(
                (slotJson) => ChatEventSlot.fromEventSlot(
                  EventSlot.fromJson(slotJson),
                ),
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
