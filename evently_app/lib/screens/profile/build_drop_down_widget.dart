import 'package:easy_localization/easy_localization.dart';
import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:evently_v2/core/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildDropDownWidget extends StatelessWidget {
  final String labelText;
  final String textView;
  final List<String> items;
  final void Function(String?)? onChanged;

  const BuildDropDownWidget({
    super.key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    required this.textView,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: context.labelMedium?.copyWith(
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: ColorsManager.blue56, width: 1.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                textView,
                style: context.labelMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              DropdownButton<String>(
                items: items.map((String item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                menuWidth: double.maxFinite,
                onChanged: onChanged,
                iconSize: 35,
                dropdownColor: ColorsManager.white,
                elevation: 0,
                iconEnabledColor: ColorsManager.blue56,
                iconDisabledColor: ColorsManager.blue56,
                focusColor: ColorsManager.blue56,
                style: context.labelMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold
                ),
                underline: Container(),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
