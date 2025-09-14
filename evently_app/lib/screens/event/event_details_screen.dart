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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
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
    ProvidersManager providerManger = Provider.of<ProvidersManager>(context);
    final args = ModalRoute.of(context)!.settings.arguments as EventModel;
    var date = DateTime.fromMillisecondsSinceEpoch(args.date);
    String fullDate = DateFormat('dd MMMM y').format(date);
    int hours = args.time ~/ 100; // يقسم على 100 علشان يجيب الساعات
    int minutes = args.time % 100; // الباقي هو الدقايق
    String period = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    if (hours == 0) hours = 12;
    String formattedTime =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $period';

    print("id : ${args.id}");
    return Scaffold(
      appBar: AppBar(
        title: Text("event_details".tr()),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: ColorsManager.blue56, size: 30),
        ),
        actions: [
          IconButton(
            onPressed: () =>Navigator.pushNamed(
              context,
              RoutesManager.eventUpdatesScreen,
              arguments: args,
            ),
            icon: Icon(MaterialCommunityIcons.note_edit_outline),
            color: ColorsManager.blue56,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("delete_event".tr()),
                    content: Text("delete_event_confirmation".tr()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("no".tr()),
                      ),
                      TextButton(
                        onPressed: () async {
                          await FireStore.deleteEventById(id: args.id);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RoutesManager.homeLayout,
                            (route) => false,
                          );
                        },
                        child: Text("yes".tr()),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(FontAwesome.trash_o),
            color: ColorsManager.red,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(args.imagePath),
              ),
              SizedBox(height: 20),
              Text(
                args.title,
                style: context.labelLarge?.copyWith(
                  color: ColorsManager.blue56,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorsManager.transparent,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: ColorsManager.blue56),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorsManager.blue56,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: ColorsManager.blue56),
                      ),
                      child: Icon(
                        Icons.calendar_month_rounded,
                        size: 25.sp,
                        color: ColorsManager.white,
                      ),
                    ),
                    SizedBox(width: 10.w),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullDate.toString(),
                          style: context.labelSmall?.copyWith(
                            color: ColorsManager.blue56,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(formattedTime, style: context.labelSmall),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorsManager.transparent,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: ColorsManager.blue56),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorsManager.blue56,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: ColorsManager.blue56),
                      ),
                      child: Icon(
                        MaterialCommunityIcons.crosshairs_gps,
                        size: 25.sp,
                        color: ColorsManager.white,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Cairo , Egypt",
                      style: context.labelSmall?.copyWith(
                        color: ColorsManager.blue56,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  color: ColorsManager.transparent,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: ColorsManager.blue56, width: 0.5),
                ),
                child: Image.asset(PngAssets.map, fit: BoxFit.fill),
              ),
              SizedBox(height: 15),
              Text("description".tr(), style: context.labelSmall),
              SizedBox(height: 15),
              Text(args.description, style: context.labelSmall),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
