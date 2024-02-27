import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:my_garage/src/garage/infra/models/auto.dart';
import 'package:my_garage/src/internal/infra/database.dart';
import 'package:my_garage/src/internal/infra/tables/auto_mileage_table.dart';
import 'package:my_garage/src/internal/infra/tables/auto_table.dart';

part 'garage_repository.g.dart';

@lazySingleton
@DriftAccessor(tables: [AutoTable, AutoMileageTable])
class GarageRepository extends DatabaseAccessor<Database>
    with _$GarageRepositoryMixin {
  GarageRepository(super.db);

  Stream<List<Auto>> watchAutoList() => select(autoTable).watch();

  Future<void> insertAuto(Auto auto) async {
    await into(autoTable).insertOnConflictUpdate(auto);
  }

  Future<Auto?> getAutoById(int id) async {
    final query = (select(autoTable)
      ..where((tbl) => tbl.id.equals(id))
      ..limit(1));
    return query.getSingleOrNull();
  }

  Future<void> updateAutoById(int id, {int? mileage, String? chassisNumber, String? bodyNumber, String? vin}) async {
    await (update(autoTable)..where((tbl) => tbl.id.equals(id))).write(
        AutoTableCompanion(
            mileage: Value(mileage),
            chassisNumber: Value(chassisNumber),
            bodyNumber: Value(bodyNumber),
            vin: Value(vin),
        ));
  }

  Future<void> deleteAutoById(int id) async {
    await (delete(autoTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
