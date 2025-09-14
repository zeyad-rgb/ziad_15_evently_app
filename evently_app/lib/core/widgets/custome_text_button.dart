import 'package:evently_v2/core/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressd;
  final TextDecoration? decoration;

  const CustomeTextButton({
    super.key,
    required this.text,
    required this.onPressd,
    this.decoration = TextDecoration.underline,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressd,
      child: Text(
        text,
        style: context.labelMedium?.copyWith(
          color: Theme.of(context).primaryColor,
          decoration: decoration,
          decorationColor: Theme.of(context).primaryColor,
          fontStyle: FontStyle.italic,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
