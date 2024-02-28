part of 'garage_auto_mileage_cubit.dart';

sealed class GarageAutoMileageState extends Equatable {
  const GarageAutoMileageState();
}

class GarageAutoMileageInProgress extends GarageAutoMileageState {
  const GarageAutoMileageInProgress();

  @override
  List<Object> get props => [];
}

class GarageAutoMileageSuccess extends GarageAutoMileageState {
  const GarageAutoMileageSuccess({ required this.mileages });

  final List<AutoMileage> mileages;

  @override
  List<Object?> get props => [mileages];
}
