import 'package:flutter/material.dart';
import 'package:my_garage/src/garage/ui/garage_add_mileage/garage_add_mileage_view.dart';

class GarageAddMileageScreen extends StatelessWidget {
  const GarageAddMileageScreen({
    super.key,
    required this.autoId,
    this.mileageId,
    this.mileageValue,
  });

  final int autoId;
  final int? mileageId;
  final int? mileageValue;

  @override
  Widget build(BuildContext context) {
    return GarageAddMileageView(autoId: autoId, mileageValue: mileageValue, mileageId: mileageId);
  }
}
