import 'package:evently_v2/core/assets/assets_manager.dart';
import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:evently_v2/core/extension/build_context_extension.dart';
import 'package:evently_v2/core/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventItem extends StatelessWidget {
  final EventModel eventModel;

  const EventItem({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity.w,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorsManager.blue56, width: 2.w),
        image: DecorationImage(
          image: AssetImage(eventModel.imagePath),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),

            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Text(
                  "${eventModel.date}".substring(0,10),
                  style: context.labelMedium?.copyWith(
                    color: ColorsManager.blue56,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                Text(
                  "${eventModel.date}",
                  style: context.labelSmall?.copyWith(
                    color: ColorsManager.blue56,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),

            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ListTile(
              title: Text(
                eventModel.description,
                style: context.labelSmall?.copyWith(
                  color: ColorsManager.black1c,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              trailing: Icon(Icons.favorite),
            ),
          ),
        ],
      ),
    );
  }
}
