import 'package:flutter/material.dart';
import 'package:my_garage/src/internal/infra/extensions/build_context_x.dart';

class GarageSaveMileageButton extends StatelessWidget {
  const GarageSaveMileageButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onPressed,
        child: Text(context.t.garageSaveMileageButton));
  }
}
