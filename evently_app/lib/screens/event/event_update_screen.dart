import 'package:easy_localization/easy_localization.dart';
import 'package:evently_v2/config/firebase/fire_store.dart';
import 'package:evently_v2/core/assets/assets_manager.dart';
import 'package:evently_v2/core/cashing/cashing.dart';
import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:evently_v2/core/extension/build_context_extension.dart';
import 'package:evently_v2/core/models/category_model.dart';
import 'package:evently_v2/core/models/event_model.dart';
import 'package:evently_v2/core/providers/providers_manager.dart';
import 'package:evently_v2/core/routes/routes_manager.dart';
import 'package:evently_v2/core/widgets/custome_elevated_button.dart';
import 'package:evently_v2/core/widgets/custome_text_button.dart';
import 'package:evently_v2/core/widgets/custome_text_form_field.dart';
import 'package:evently_v2/screens/home/category_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EventUpdateScreen extends StatefulWidget {
  const EventUpdateScreen({super.key});

  @override
  State<EventUpdateScreen> createState() => _EventUpdateScreenState();
}

class _EventUpdateScreenState extends State<EventUpdateScreen> {
  bool isDark = Cashing.getTheme();
  List<String> images = [
    PngAssets.sport,
    PngAssets.birthDay,
    PngAssets.meeting,
    PngAssets.gaming,
    PngAssets.eating,
    PngAssets.holiday,
    PngAssets.exhibition,
    PngAssets.workShop,
    PngAssets.bookClub,
  ];

  List<String> images2 = [
    PngAssets.sport2,
    PngAssets.birthDay2,
    PngAssets.meeting2,
    PngAssets.gaming2,
    PngAssets.eating2,
    PngAssets.holiday2,
    PngAssets.exhibition2,
    PngAssets.workShop2,
    PngAssets.bookClub2,
  ];
  int selectedIndexTab = 0;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<CategoryModel> categories = [
    CategoryModel(name: "sports".tr(), iconPath: FontAwesome.bicycle),
    CategoryModel(name: "birthday".tr(), iconPath: FontAwesome.birthday_cake),
    CategoryModel(name: "meeting".tr(), iconPath: FontAwesome.laptop),
    CategoryModel(name: "gaming".tr(), iconPath: FontAwesome.gamepad),
    CategoryModel(name: "eating".tr(), iconPath: MaterialCommunityIcons.pizza),
    CategoryModel(name: "holiday".tr(), iconPath: MaterialCommunityIcons.beach),
    CategoryModel(
      name: "exhibition".tr(),
      iconPath: MaterialCommunityIcons.palette_outline,
    ),
    CategoryModel(
      name: "workshop".tr(),
      iconPath: MaterialCommunityIcons.tools,
    ),
    CategoryModel(name: "bookclub".tr(), iconPath: MaterialCommunityIcons.book),
  ];
  List<String> categoryNames = [
    "sports",
    "birthday",
    "meeting",
    "gaming",
    "eating",
    "holiday",
    "exhibition",
    "workshop",
    "bookclub",
  ];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EventModel;

    return Scaffold(
      appBar: AppBar(
        title: Text("update_event".tr()),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: ColorsManager.blue56, size: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    isDark
                        ? images2[selectedIndexTab]
                        : images[selectedIndexTab],
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 50.h,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 10.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) => InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        setState(() {
                          selectedIndexTab = index;
                        });
                      },
                      child: CategoryItem(
                        isSelected: selectedIndexTab == index,
                        categoryModel: categories[index],
                        bgSelectedColor: isDark
                            ? ColorsManager.blue56
                            : ColorsManager.blue56,
                        bgUnSelectedColor: isDark
                            ? ColorsManager.transparent
                            : ColorsManager.transparent,
                        textSelectedColor: isDark
                            ? ColorsManager.black10
                            : ColorsManager.white,
                        textUnSelectedColor: isDark
                            ? ColorsManager.blue56
                            : ColorsManager.blue56,
                        borderSelectedColor: isDark
                            ? ColorsManager.blue56
                            : ColorsManager.blue56,
                        borderUnSelectedColor: isDark
                            ? ColorsManager.blue56
                            : ColorsManager.blue56,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "title".tr(),
                  style: context.labelSmall?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomeTextFormField(
                  prefixIcon: Icons.edit,
                  hintText: "title".tr(),
                  controller: _titleController,
                  prefixIconColor: isDark
                      ? ColorsManager.whiteF4
                      : ColorsManager.grey7B,
                ),
                SizedBox(height: 16.h),
                Text(
                  "description".tr(),
                  style: context.labelSmall?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomeTextFormField(
                  hintText: "description".tr(),
                  maxLines: 3,
                  controller: _descriptionController,
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.date_range),
                        SizedBox(width: 8.w),
                        Text(
                          "event_date".tr(),
                          style: context.labelSmall?.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CustomeTextButton(
                      text: selectedDate == null
                          ? "choose_date".tr()
                          : DateFormat.yMMMMd(
                              context.locale.toString(),
                            ).format(selectedDate!),
                      onPressd: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          currentDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      decoration: TextDecoration.none,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.watch_later_outlined),
                        SizedBox(width: 8.w),
                        Text(
                          "event_time".tr(),
                          style: context.labelSmall?.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CustomeTextButton(
                      text: selectedTime == null
                          ? "choose_time".tr()
                          : selectedTime!.format(context),
                      onPressd: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedTime = picked;
                          });
                        }
                      },
                      decoration: TextDecoration.none,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                CustomeElevatedButton(
                  label: "update_event".tr(),
                  onPressed: () async {
                    if (selectedDate == null ||
                        selectedTime == null ||
                        _titleController.text.isEmpty ||
                        _descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'please_select_date_time_please_fill_all_fields'
                                .tr(),
                          ),
                        ),
                      );
                      return;
                    }
                    EventModel eventModel = EventModel(
                      id: args.id,
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      date: selectedDate!.millisecondsSinceEpoch,
                      time: selectedTime!.hour * 100 + selectedTime!.minute,
                      imagePath: images[selectedIndexTab],
                      categoryName: categoryNames[selectedIndexTab],
                    );

                    await FireStore.UpdateEvent(eventModel, args.id);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("event_updated_success".tr()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutesManager.homeLayout,
                              (route) => false,
                            ),
                            child: Text("ok".tr()),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
