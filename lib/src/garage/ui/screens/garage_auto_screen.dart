import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_garage/src/garage/infra/models/auto.dart';
import 'package:my_garage/src/garage/infra/models/auto_mileage.dart';
import 'package:my_garage/src/garage/ui/garage_auto/garage_auto_error_view.dart';
import 'package:my_garage/src/garage/ui/garage_auto/garage_auto_view.dart';
import 'package:my_garage/src/garage/use_cases/garage_auto/garage_auto_cubit.dart';
import 'package:my_garage/src/garage/use_cases/garage_auto_mileage/garage_auto_mileage_cubit.dart';
import 'package:my_garage/src/injection.dart';
import 'package:my_garage/src/internal/infra/extensions/build_context_x.dart';
import 'package:my_garage/src/router.dart';

class GarageAutoScreen extends StatelessWidget {
  const GarageAutoScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<GarageAutoCubit>()..started(id)
        ),
        BlocProvider(
          create: (_) => getIt<GarageAutoMileageCubit>()..started(autoId: id)
        ),
      ],
      child: BlocConsumer<GarageAutoCubit, GarageAutoState>(
        builder: _builder,
        buildWhen: (previous, current) =>
            current is GarageAutoInProgress ||
            current is GarageAutoInitial ||
            current is GarageAutoFailure,
        listener: _listener,
      ),
    );
  }

  void _listener(BuildContext context, GarageAutoState state) {
    if (state is GarageAutoNonFatalFailure) {
      context.showSnackBar(state.error.toString());
    } else if (state is GarageAutoSuccess) {
      context.pop();
    }
  }

  Widget _builder(BuildContext context, GarageAutoState autoState) {
    if (autoState is GarageAutoInitial) {
      return BlocBuilder<GarageAutoMileageCubit, GarageAutoMileageState>(
        builder: (context, mileageState) {
          return GarageAutoView(
            auto: autoState.auto,
            // TODO(DanilAbdrafikov): Implement mileage history
            mileage: switch (mileageState) {
              GarageAutoMileageInProgress() => [],
              GarageAutoMileageSuccess(:final mileages) => mileages,
            },
            onMileageDelete: (int id) {
              context.garageAutoMileage.deleted(mileageId: id);
            },
            onMileageUpdate: (AutoMileage mileage) async {
              final updatedMileage = await context.pushNamed<AutoMileage?>(
                  RouteName.garageAddMileage.name,
                  pathParameters: {'id': autoState.auto.id.toString()},
                  queryParameters: {
                    'autoId': autoState.auto.id.toString(),
                    'mileageId': mileage.id.toString(),
                    'mileageValue': mileage.value.toString(),
                  }
              );
              if (!context.mounted || updatedMileage == null) return;
              context.garageAutoMileage.updated(mileageId: updatedMileage.id, value: updatedMileage.value);
            },
            onDelete: context.garageAuto.deleted,
            onUpdate: () async {
              final auto = await context.pushNamed<Auto?>(
                RouteName.garageUpdate.name,
                pathParameters: {'id': autoState.auto.id.toString()},
                queryParameters: <String, String?>{
                  'body_number': autoState.auto.bodyNumber,
                  'chassis_number': autoState.auto.chassisNumber,
                  'vin': autoState.auto.vin,
                  'mileage': autoState.auto.mileage?.toString(),
                },
              );
              if (!context.mounted || auto == null) return;
              return context.garageAuto.updated(
                bodyNumber: auto.bodyNumber,
                chassisNumber: auto.chassisNumber,
                vin: auto.vin,
                mileage: auto.mileage,
              );
            },
          );
        }
      );
    } else if (autoState is GarageAutoFailure) {
      return GarageAutoErrorView(
        child: Text(autoState.error.toString()),
        onRetry: () => context.garageAuto.started(id),
      );
    }
    return GarageAutoView(
      auto: null,
      mileage: null,
      onDelete: null,
      onUpdate: null,
      onMileageDelete: (_) {},
      onMileageUpdate: (_) {},
    );
  }
}
