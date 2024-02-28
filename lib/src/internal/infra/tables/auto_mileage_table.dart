import 'package:drift/drift.dart';
import 'package:my_garage/src/garage/infra/models/auto_mileage.dart';
import 'package:my_garage/src/internal/infra/tables/auto_table.dart';

@UseRowClass(AutoMileage)
class AutoMileageTable extends Table {
  const AutoMileageTable();

  @override
  String get tableName => 'auto_mileage';

  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();

  IntColumn get autoId =>
      integer().references(AutoTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get value => integer()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}
