import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:my_garage/src/garage/ui/screens/garage_add_screen.dart';
import 'package:my_garage/src/garage/ui/screens/garage_auto_screen.dart';
import 'package:my_garage/src/garage/ui/screens/garage_screen.dart';
import 'package:my_garage/src/garage/ui/screens/garage_update_screen.dart';
import 'package:my_garage/src/internal/infra/database.dart';
import 'package:my_garage/src/internal/infra/extensions/string_x.dart';

import 'garage/ui/screens/garage_add_mileage_screen.dart';

export 'package:go_router/go_router.dart';

part 'route_name.dart';

@module
abstract class RouterInjectableModule {
  const RouterInjectableModule();

  @lazySingleton
  GoRouter router(Database database) {
    return GoRouter(
      debugLogDiagnostics: kDebugMode,
      initialLocation: RouteName.garage.path,
      routes: [
        GoRoute(
          path: RouteName.garage.path,
          name: RouteName.garage.name,
          builder: (_, state) => GarageScreen(key: state.pageKey),
          routes: [
            GoRoute(
              path: RouteName.garageAdd.path,
              name: RouteName.garageAdd.name,
              builder: (_, state) => GarageAddScreen(key: state.pageKey),
            ),
            GoRoute(
              path: RouteName.garageAuto.path,
              name: RouteName.garageAuto.name,
              builder: (_, state) => GarageAutoScreen(
                key: state.pageKey,
                id: int.parse(state.pathParameters['id']!),
              ),
              routes: [
                GoRoute(
                  path: RouteName.garageUpdate.path,
                  name: RouteName.garageUpdate.name,
                  builder: (_, state) => GarageUpdateScreen(
                    key: state.pageKey,
                    bodyNumber: state.uri.queryParameters['body_number'],
                    chassisNumber: state.uri.queryParameters['chassis_number'],
                    vin: state.uri.queryParameters['vin'],
                    mileage: int.tryParse(
                      state.uri.queryParameters['mileage'] ?? '',
                    ),
                  ),
                ),
                GoRoute(
                  path: RouteName.garageAddMileage.path,
                  name: RouteName.garageAddMileage.name,
                  builder: (_, state) {
                    return GarageAddMileageScreen(
                      key: state.pageKey,
                      autoId: int.parse(state.uri.queryParameters['autoId']!),
                      mileageId: int.tryParse(state.uri.queryParameters['mileageId'] ?? ''),
                      mileageValue: int.tryParse(state.uri.queryParameters['mileageValue'] ?? ''),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: RouteName.easterEgg.path,
          name: RouteName.easterEgg.name,
          builder: (_, state) => DriftDbViewer(database),
        ),
      ],
    );
  }
}
