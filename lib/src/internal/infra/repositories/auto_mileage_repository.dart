import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:my_garage/src/garage/infra/models/auto.dart';
import 'package:my_garage/src/garage/infra/models/auto_mileage.dart';
import 'package:my_garage/src/internal/infra/database.dart';
import 'package:my_garage/src/internal/infra/tables/auto_mileage_table.dart';
import 'package:my_garage/src/internal/infra/tables/auto_table.dart';

part 'auto_mileage_repository.g.dart';

@lazySingleton
@DriftAccessor(tables: [AutoMileageTable])
class AutoMileageRepository extends DatabaseAccessor<Database> with _$AutoMileageRepositoryMixin {
  AutoMileageRepository(super.db);

  Stream<List<AutoMileage>> watchAutoMileageList({ required int autoId }) => (select(autoMileageTable)
    ..where((tbl) => tbl.autoId.equals(autoId))
    ..orderBy([
      (m) => OrderingTerm(expression: m.createdAt, mode: OrderingMode.desc)
    ]))
    .watch();

  Future<void> insertMileage(AutoMileage mileage) async {
    await into(autoMileageTable).insertOnConflictUpdate(mileage);
  }

  Future<AutoMileage?> getMileageById(int id) async {
    final query = (select(autoMileageTable)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1));
    return query.getSingleOrNull();
  }

  Future<void> updateMileageById(int id, {required int value}) async {
    await (update(autoMileageTable)..where((tbl) => tbl.id.equals(id))).write(
        AutoMileageTableCompanion(
          value: Value(value),
        ));
  }

  Future<void> deleteMileageById(int id) async {
    await (delete(autoMileageTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
