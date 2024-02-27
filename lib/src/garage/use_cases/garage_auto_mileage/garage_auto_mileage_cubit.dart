import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_garage/src/garage/infra/models/auto_mileage.dart';
import 'package:my_garage/src/internal/infra/repositories/auto_mileage_repository.dart';

part 'garage_auto_mileage_state.dart';

@injectable
class GarageAutoMileageCubit extends Cubit<GarageAutoMileageState> {
  GarageAutoMileageCubit(this._repository) : super(const GarageAutoMileageInProgress()) {}

  final AutoMileageRepository _repository;
  late final StreamSubscription<List<AutoMileage>> _sub;

  @override
  Future<void> close() {
    _sub.cancel();
    return super.close();
  }

  void started({ required int autoId }) async {
    _sub = _repository.watchAutoMileageList(autoId: autoId).listen(_listener);
  }

  void deleted({ required int mileageId }) async {
    await _repository.deleteMileageById(mileageId);
  }

  void updated({ required int mileageId, required int value }) async {
    await _repository.updateMileageById(mileageId, value: value);
  }

  void _listener(List<AutoMileage> mileages) {
    if (isClosed) return;
    emit(GarageAutoMileageSuccess(mileages: mileages));
  }
}


extension GarageAutoMileageCubitX on BuildContext {
  GarageAutoMileageCubit get garageAutoMileage => read<GarageAutoMileageCubit>();
}
