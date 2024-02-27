part of 'router.dart';

enum RouteName {
  garage('/garage'),
  garageAdd('add'),
  garageAuto('auto/:id'),
  garageUpdate('update'),
  easterEgg('/easter-egg'),
  garageAddMileage('add-mileage');

  const RouteName(this.path);

  final String path;

  String get name =>
      toString().substring(toString().indexOf('.') + 1).toSnakeCase;
}
