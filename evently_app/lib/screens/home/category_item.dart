import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:evently_v2/core/extension/build_context_extension.dart';
import 'package:evently_v2/core/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  final bool isSelected;
  final CategoryModel categoryModel;
  final Color bgSelectedColor;
  final Color bgUnSelectedColor;
  final Color textSelectedColor;
  final Color textUnSelectedColor;
  final Color borderSelectedColor;
  final Color borderUnSelectedColor;

  const CategoryItem({
    super.key,
    required this.isSelected,
    required this.categoryModel,
    required this.bgSelectedColor,
    required this.bgUnSelectedColor,
    required this.textSelectedColor,
    required this.textUnSelectedColor,
    required this.borderSelectedColor,
    required this.borderUnSelectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: isSelected ? bgSelectedColor : bgUnSelectedColor,
        borderRadius: BorderRadius.circular(45.r),
        border: Border.all(
          color: isSelected ? borderSelectedColor : borderUnSelectedColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            categoryModel.iconPath,
            color: isSelected ? textSelectedColor : textUnSelectedColor,
          ),
          SizedBox(width: 10.w),
          Text(
            categoryModel.name,
            style: context.labelSmall?.copyWith(
              color: isSelected ? textSelectedColor : textUnSelectedColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
