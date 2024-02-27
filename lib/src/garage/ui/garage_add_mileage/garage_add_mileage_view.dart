import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_garage/src/garage/infra/models/auto_mileage.dart';
import 'package:my_garage/src/internal/infra/extensions/build_context_x.dart';
import 'package:my_garage/src/router.dart';

import 'garage_save_mileage_button.dart';

class GarageAddMileageView extends StatefulWidget {
  const GarageAddMileageView({
    super.key,
    required this.autoId,
    this.mileageId,
    this.mileageValue,
  });

  final int autoId;
  final int? mileageId;
  final int? mileageValue;

  @override
  State<GarageAddMileageView> createState() => _GarageAddMileageViewState();
}

class _GarageAddMileageViewState extends State<GarageAddMileageView> {
  late final GlobalKey<FormState> _key;

  late AutoMileage _mileage = AutoMileage(
      id: widget.mileageId ?? 0,
      autoId: widget.autoId,
      value: widget.mileageValue ?? 0,
      createdAt: DateTime.now());

  @override
  void initState() {
    super.initState();
    _key = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.t.garageAddMileageAppBarTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: widget.mileageValue != null ? '${widget.mileageValue}' : '',
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: context.t.garageAddMileageValueLabel,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: _emptyValidator,
                  onSaved: (String? text) {
                    _mileage = _mileage.copyWith(value: int.parse(text!));
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: GarageSaveMileageButton(
                    onPressed: () {
                      _key.currentState?.save();
                      context.pop(_mileage);
                    },
                  )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _emptyValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return context.t.garageAddMileageEmptyError;
    }
    return null;
  }
}
