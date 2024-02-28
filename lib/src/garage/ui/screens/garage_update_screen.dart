import 'package:flutter/material.dart';
import 'package:my_garage/src/garage/infra/models/auto.dart';
import 'package:my_garage/src/garage/ui/garage_update/garage_update_view.dart';

class GarageUpdateScreen extends StatelessWidget {
  const GarageUpdateScreen({
    super.key,
    required this.bodyNumber,
    required this.chassisNumber,
    required this.vin,
    required this.mileage,
  });

  final String? bodyNumber;
  final String? chassisNumber;
  final String? vin;
  final int? mileage;

  @override
  Widget build(BuildContext context) {
    return GarageUpdateView(
      auto: Auto.empty().copyWith(
        bodyNumber: bodyNumber,
        chassisNumber: chassisNumber,
        vin: vin,
      ),
    );
  }
}
