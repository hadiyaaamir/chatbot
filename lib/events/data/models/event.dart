part of 'models.dart';

class Event extends Option {
  const Event({
    required this.id,
    required this.title,
    required this.images,
    required this.category,
    required this.details,
    required this.city,
    required this.country,
    required this.createdAt,
    required this.location,
    required this.price,
    required this.slots,
  });

  final String id;

  final String title;
  final String category;
  final int price;
  final Details details;

  final List<String> images;

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

    return smallestDate == largestDate
        ? formatDate(smallestDate)
        : '${formatDate(smallestDate)} to ${formatDate(largestDate)}';
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
    List<String>? images,
    String? category,
    int? price,
    Details? details,
    String? city,
    String? country,
    LatLng? location,
    DateTime? createdAt,
    List<ChatEventSlot>? slots,
  }) {
    return Event(
        id: id ?? this.id,
        title: title ?? this.title,
        images: images ?? this.images,
        category: category ?? this.category,
        city: city ?? this.city,
        country: country ?? this.country,
        createdAt: createdAt ?? this.createdAt,
        details: details ?? this.details,
        location: location ?? this.location,
        price: price ?? this.price,
        slots: slots ?? this.slots);
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      images: json['images'] != null
          ? (json['images'] as List<dynamic>).cast<String>()
          : [],
      category: json['category'] as String? ?? '',
      city: json['city'] as String? ?? '',
      country: json['country'] as String? ?? '',
      details: Details.fromJson(json['details'] as Map<String, dynamic>? ?? {}),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      location: json['location'] != null
          ? LatLng(
              latitude: double.parse(json['location'][0] as String),
              longitude: double.parse(json['location'][1] as String),
            )
          : LatLng(),
      price: json['price'] as int? ?? 0,
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

  bool matchesSearch(String searchText) {
    searchText = searchText.toLowerCase();
    return title.toLowerCase().contains(searchText) ||
        city.toLowerCase().contains(searchText) ||
        country.toLowerCase().contains(searchText) ||
        numberOfDays.toString().contains(searchText) ||
        dayRange.toLowerCase().contains(searchText);
  }

  @override
  List<Object> get props => [
        id,
        title,
        images,
        category,
        price,
        city,
        country,
        location,
        createdAt,
        slots,
      ];
}
