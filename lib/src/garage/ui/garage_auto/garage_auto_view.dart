import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_garage/src/garage/infra/models/auto.dart';
import 'package:my_garage/src/garage/infra/models/auto_mileage.dart';
import 'package:my_garage/src/garage/ui/garage/garage_empty_view.dart';
import 'package:my_garage/src/garage/ui/garage/garage_header_delegate.dart';
import 'package:my_garage/src/garage/ui/garage_auto/garage_auto_characteristic.dart';
import 'package:my_garage/src/garage/ui/garage_auto/garage_auto_list_tile.dart';
import 'package:my_garage/src/garage/ui/garage_auto/garage_auto_mileage_list_tile.dart';
import 'package:my_garage/src/internal/infra/extensions/build_context_x.dart';

class GarageAutoView extends StatelessWidget {
  const GarageAutoView({
    super.key,
    required this.auto,
    required this.mileage,
    required this.onDelete,
    required this.onUpdate,
    required this.onMileageDelete,
    required this.onMileageUpdate,
  });

  final Auto? auto;
  final List<AutoMileage>? mileage;
  final VoidCallback? onDelete;
  final VoidCallback? onUpdate;
  final void Function(int id) onMileageDelete;
  final void Function(AutoMileage mileage) onMileageUpdate;

  @override
  Widget build(BuildContext context) {
    final auto = this.auto;
    final mileage = this.mileage;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.garageAutoAppBarTitle),
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: auto == null
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverToBoxAdapter(
                    child: GarageAutoListTile.detail(
                      title: Text(context.t.garageAutoAboutTitle),
                      subtitle: Text(
                        context.t.garageAutoName(auto.name, auto.year),
                      ),
                      characteristics: [
                        GarageAutoCharacteristic(
                          name: context.t.garageAutoMileageLabel,
                          value: auto.mileage != null
                              ? context.t.garageAutoMileage(
                                  NumberFormat.decimalPattern()
                                      .format(auto.mileage),
                                )
                              : null,
                        ),
                        GarageAutoCharacteristic(
                          name: context.t.garageAutoBodyNumberLabel,
                          value: auto.bodyNumber,
                        ),
                        GarageAutoCharacteristic(
                          name: context.t.garageAutoChassisNumberLabel,
                          value: auto.chassisNumber,
                        ),
                        GarageAutoCharacteristic(
                          name: context.t.garageAutoVinLabel,
                          value: auto.vin,
                        ),
                      ],
                      onUpdate: onUpdate,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
                SliverMainAxisGroup(
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: GarageHeaderDelegate(
                        loading: mileage == null,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(context.t.garageAutoMileageTitle),
                      ),
                    ),
                    if (mileage != null && mileage.isNotEmpty)
                      SliverList.builder(
                        itemCount: mileage.length,
                        itemBuilder: (_, index) {
                          final m = mileage[index];
                          return GarageAutoMileageListTile(
                            mileage: m.value,
                            createdAt: m.createdAt,
                            onDelete: () => onMileageDelete(m.id),
                            onEdit: () => onMileageUpdate(m),
                          );
                        },
                      )
                    else
                      SliverToBoxAdapter(
                        child: GarageEmptyView(
                          padding: EdgeInsets.symmetric(
                            vertical: context.data.size.height * 0.05,
                            horizontal: 16.0,
                          ),
                          child: Text(context.t.garageAutoMileageEmptyLabel),
                        ),
                      )
                  ],
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: context.data.padding.bottom + 16.0),
                )
              ],
            ),
    );
  }
}
