part of 'models.dart';

class Details extends Equatable {
  const Details({
    this.description = '',
    this.included = const [],
    this.excluded = const [],
    this.facilities = const [],
    this.importantInfo = const [],
    this.toBring = const [],
  });

  final String description;
  final List<String> included;
  final List<String> excluded;
  final List<String> facilities;
  final List<String> importantInfo;
  final List<String> toBring;

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      description: json['description'] as String? ?? '',
      included: _parseStringList(json['included'] as List<dynamic>?) ?? [],
      excluded: _parseStringList(json['excluded'] as List<dynamic>?) ?? [],
      facilities: _parseStringList(json['facilities'] as List<dynamic>?) ?? [],
      importantInfo:
          _parseStringList(json['importantInfo'] as List<dynamic>?) ?? [],
      toBring: _parseStringList(json['toBring'] as List<dynamic>?) ?? [],
    );
  }

  static List<String>? _parseStringList(List<dynamic>? data) {
    return data?.cast<String>();
  }

  @override
  List<Object> get props => [
        description,
        included,
        excluded,
        facilities,
        importantInfo,
        toBring,
      ];
}
