import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_garage/src/internal/infra/extensions/build_context_x.dart';

class GarageAutoMileageListTile extends StatelessWidget {
  const GarageAutoMileageListTile({
    super.key,
    required this.mileage,
    required this.createdAt,
    required this.onDelete,
    required this.onEdit
  });

  final int mileage;
  final DateTime createdAt;
  final VoidCallback onDelete;
  final VoidCallback onEdit;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: const CircleAvatar(child: Icon(Icons.route_outlined)),
      title: Text(
        context.t.garageAutoMileage(
          NumberFormat.decimalPattern().format(mileage),
        ),
        maxLines: 1,
      ),
      subtitle: Text(
        context.t.garageAutoMileageCreatedAtLabel(
          DateFormat.yMMMd(context.t.localeName).format(createdAt),
          TimeOfDay.fromDateTime(createdAt).format(context),
        ),
        style: context.textTheme.bodyMedium
            ?.copyWith(color: context.colors.secondary),
        maxLines: 1,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
          const SizedBox(width: 8),
          IconButton(onPressed: onDelete, icon: const Icon(Icons.delete, color: Colors.red))
        ],
      ),
    );
  }
}
