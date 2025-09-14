import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:evently_v2/core/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

class CustomeElevatedButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  const CustomeElevatedButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: context.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorsManager.white,
          ),
        ),
      ),
    );
  }
}
