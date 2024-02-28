import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';

import '../../../internal/infra/database.dart';

class AutoMileage extends Equatable implements Insertable<AutoMileage> {
  const AutoMileage({
    required this.id,
    required this.autoId,
    required this.value,
    required this.createdAt,
  });

  final int id;
  final int autoId;
  final int value;
  final DateTime createdAt;

  @override
  List<Object> get props => [id, autoId, value, createdAt];

  AutoMileage copyWith({
    int? id,
    int? autoId,
    int? value,
    DateTime? createdAt,
  }) {
    return AutoMileage(
      id: id ?? this.id,
      autoId: autoId ?? this.autoId,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return AutoMileageTableCompanion.insert(
      autoId: autoId,
      value: value,
    ).toColumns(nullToAbsent);
  }
}
