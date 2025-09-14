import 'package:evently_v2/core/cashing/cashing.dart';
import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:evently_v2/core/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeTextFormField extends StatelessWidget {
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final IconData? sufixIcon;
  final String? label;
  final String? hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final int? maxLines;

  final void Function()? onPressedSufixIcon;

  const CustomeTextFormField({
    super.key,
    this.prefixIcon,
    this.label,
    this.keyboardType = TextInputType.text,
    this.sufixIcon,
    this.hintText,
    this.prefixIconColor,
    this.validator,

    this.controller,
    this.obscureText = false,
    this.onPressedSufixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Cashing.getTheme();

    return TextFormField(
      controller: controller,
      textAlign: TextAlign.left,
      maxLines: maxLines,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        prefixIconColor: prefixIconColor,
        suffixIcon: sufixIcon != null
            ? IconButton(icon: Icon(sufixIcon), onPressed: onPressedSufixIcon)
            : null,
        suffixIconColor: Theme.of(context).primaryColorLight,
        labelText: label,
        labelStyle: GoogleFonts.inter(
          color: Theme.of(context).primaryColorLight,
        ),
        hintText: hintText,
        hintStyle: context.labelSmall?.copyWith(
          color: Theme.of(context).primaryColorLight,
          fontWeight: FontWeight.w700,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDark ? ColorsManager.blue56 : ColorsManager.grey7B,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDark ? ColorsManager.blue56 : ColorsManager.grey7B,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsManager.redF5),
          borderRadius: BorderRadius.circular(16.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsManager.redF5),
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      style: context.labelSmall,
    );
  }
}
