part of 'models.dart';

abstract class Option extends Equatable {
  const Option();

  factory Option.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
