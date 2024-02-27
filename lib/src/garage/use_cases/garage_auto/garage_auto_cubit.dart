import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_garage/src/garage/infra/models/auto.dart';
import 'package:my_garage/src/garage/infra/models/auto_mileage.dart';
import 'package:my_garage/src/internal/infra/repositories/auto_mileage_repository.dart';
import 'package:my_garage/src/internal/infra/repositories/garage_repository.dart';

part 'garage_auto_state.dart';

@injectable
class GarageAutoCubit extends Cubit<GarageAutoState> {
  GarageAutoCubit(this._garageRepository, this._mileageRepository) : super(const GarageAutoInProgress());

  final GarageRepository _garageRepository;
  final AutoMileageRepository _mileageRepository;

  void started(int id) async {
    try {
      emit(const GarageAutoInProgress());
      final auto = await _garageRepository.getAutoById(id);
      if (isClosed) return;
      if (auto == null) return emit(const GarageAutoSuccess());
      emit(GarageAutoInitial(auto));
    } catch (e) {
      if (isClosed) return;
      emit(GarageAutoFailure(e));
    }
  }

  void deleted() async {
    final state = this.state;
    if (state is! GarageAutoInitial) return;

    try {
      emit(const GarageAutoInProgress());
      await _garageRepository.deleteAutoById(state.auto.id);
      if (isClosed) return;
      emit(const GarageAutoSuccess());
    } catch (e) {
      if (isClosed) return;
      emit(GarageAutoNonFatalFailure(e));
      emit(state);
    }
  }

  // TODO(DanilAbdrafikov): Update body number, chassis number, vin fields
  // UPD: DONE!
  void updated({
    required String? bodyNumber,
    required String? chassisNumber,
    required String? vin,
    required int? mileage,
  }) async {
    final state = this.state;
    if (state is! GarageAutoInitial) return;

    try {
      emit(const GarageAutoInProgress());
      await _garageRepository.updateAutoById(
            state.auto.id,
            mileage: mileage,
            chassisNumber: chassisNumber,
            bodyNumber: bodyNumber,
            vin: vin);
      if (mileage != null) {
        await _mileageRepository.insertMileage(AutoMileage(
            id: 0,
            autoId: state.auto.id,
            value: mileage,
            createdAt: DateTime.now()));
      };
      if (isClosed) return;
      return started(state.auto.id);
    } catch (e) {
      if (isClosed) return;
      emit(GarageAutoNonFatalFailure(e));
      emit(state);
    }
  }
}

extension GarageAutoCubitX on BuildContext {
  GarageAutoCubit get garageAuto => read<GarageAutoCubit>();
}
