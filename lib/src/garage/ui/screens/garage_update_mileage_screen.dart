import 'package:flutter/material.dart';

import '../garage_update_mileage/garage_update_mileage_view.dart';

class GarageUpdateMileageScreen extends StatelessWidget {
  const GarageUpdateMileageScreen({
    super.key,
    required this.autoId,
    required this.mileageId,
    required this.mileageValue,
  });

  final int autoId;
  final int mileageId;
  final int mileageValue;

  @override
  Widget build(BuildContext context) {
    return GarageUpdateMileageView(autoId: autoId, mileageValue: mileageValue, mileageId: mileageId);
  }
}
