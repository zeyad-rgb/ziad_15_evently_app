import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_v2/config/firebase/fire_store.dart';
import 'package:evently_v2/core/extension/build_context_extension.dart';
import 'package:evently_v2/core/models/event_model.dart';
import 'package:evently_v2/core/providers/providers_manager.dart';
import 'package:evently_v2/core/providers/user_provider.dart';
import 'package:evently_v2/core/routes/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:evently_v2/core/assets/assets_manager.dart';
import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:evently_v2/core/models/category_model.dart';
import 'category_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndexTab = 0;
  String username = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserProvider>(context, listen: false).initUser();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Consumer<ProvidersManager>(
      builder: (context, providerManger, child) {
        bool isDark = providerManger.isDark;
        List<CategoryModel> categories = [
          CategoryModel(name: "all".tr(), iconPath: FontAwesome.list),
          CategoryModel(name: "sports".tr(), iconPath: FontAwesome.bicycle),
          CategoryModel(
            name: "birthday".tr(),
            iconPath: FontAwesome.birthday_cake,
          ),
          CategoryModel(name: "meeting".tr(), iconPath: FontAwesome.laptop),
          CategoryModel(name: "gaming".tr(), iconPath: FontAwesome.gamepad),
          CategoryModel(
            name: "eating".tr(),
            iconPath: MaterialCommunityIcons.pizza,
          ),
          CategoryModel(
            name: "holiday".tr(),
            iconPath: MaterialCommunityIcons.beach,
          ),
          CategoryModel(
            name: "exhibition".tr(),
            iconPath: MaterialCommunityIcons.palette_outline,
          ),
          CategoryModel(
            name: "workshop".tr(),
            iconPath: MaterialCommunityIcons.tools,
          ),
          CategoryModel(
            name: "bookclub".tr(),
            iconPath: MaterialCommunityIcons.book,
          ),
        ];

        List<String> categoryNames = [
          "all".tr(),
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
        return Scaffold(
          extendBody: true,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: REdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 25.h,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? ColorsManager.transparent
                        : ColorsManager.blue56,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${"welcome_back".tr()} ✨",
                                style: GoogleFonts.inter(
                                  color: ColorsManager.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                userProvider.userModel != null
                                    ? userProvider.userModel!.name
                                    : '...',
                                style: GoogleFonts.inter(
                                  color: ColorsManager.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.sp,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  SvgPicture.asset(SvgAssets.map),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "location".tr(),
                                    style: GoogleFonts.inter(
                                      color: ColorsManager.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  providerManger.toggleTheme(
                                    !providerManger.isDark,
                                  );
                                },
                                color: isDark
                                    ? ColorsManager.whiteF4
                                    : ColorsManager.white,
                                icon: Icon(
                                  isDark ? Icons.light_mode : Icons.dark_mode,
                                ),
                              ),
                              SizedBox(width: 10),

                              InkWell(
                                onTap: () {
                                  if (context.locale.languageCode == 'en') {
                                    providerManger.changeLanguage(
                                      const Locale('ar'),
                                      context,
                                    );
                                  } else {
                                    providerManger.changeLanguage(
                                      const Locale('en'),
                                      context,
                                    );
                                  }
                                },
                                child: Card(
                                  color: isDark
                                      ? ColorsManager.whiteF4
                                      : ColorsManager.white,
                                  child: Padding(
                                    padding: REdgeInsets.all(8.0),
                                    child: Text(
                                      context.locale.languageCode == 'en'
                                          ? "Ar"
                                          : "En",
                                      style: GoogleFonts.inter(
                                        color: isDark
                                            ? ColorsManager.black10
                                            : ColorsManager.blue56,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 25.h),

                      SizedBox(
                        height: 45.h,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10.w),
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return InkWell(
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
                                    : ColorsManager.white,
                                bgUnSelectedColor: isDark
                                    ? ColorsManager.transparent
                                    : ColorsManager.blue56,
                                textSelectedColor: isDark
                                    ? ColorsManager.whiteF4
                                    : ColorsManager.blue56,
                                textUnSelectedColor: isDark
                                    ? ColorsManager.whiteF4
                                    : ColorsManager.white,
                                borderSelectedColor: isDark
                                    ? ColorsManager.blue56
                                    : ColorsManager.blue56,
                                borderUnSelectedColor: isDark
                                    ? ColorsManager.blue56
                                    : ColorsManager.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot<EventModel>>(
                  stream: FireStore.getAllEvents(
                    categoryName: categoryNames[selectedIndexTab],
                  ),

                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'something_went_wrong'.tr(),
                            style: context.labelMedium?.copyWith(
                              color: ColorsManager.blue56,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (!snapshot.hasData) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'no_data_found'.tr(),
                            style: context.labelMedium?.copyWith(
                              color: ColorsManager.blue56,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'no_data_found'.tr(),
                            style: context.labelMedium?.copyWith(
                              color: ColorsManager.blue56,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var date = DateTime.fromMillisecondsSinceEpoch(
                              snapshot.data!.docs[index].data().date,
                            );
                            String month = DateFormat('MMM').format(date);

                            EventModel events = EventModel(
                              id: snapshot.data!.docs[index].data().id,
                              userId: snapshot.data!.docs[index].data().userId,
                              title: snapshot.data!.docs[index].data().title,
                              description: snapshot.data!.docs[index]
                                  .data()
                                  .description,
                              categoryName: snapshot.data!.docs[index]
                                  .data()
                                  .categoryName,
                              date: snapshot.data!.docs[index].data().date,
                              time: snapshot.data!.docs[index].data().time,
                              imagePath: snapshot.data!.docs[index]
                                  .data()
                                  .imagePath,
                            );
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, RoutesManager.eventDetailsScreen,

                                arguments: events);
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                width: double.infinity.w,
                                height: 200.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: ColorsManager.blue56,
                                    width: 2.w,
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(events.imagePath),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 8.h,
                                      ),

                                      decoration: BoxDecoration(
                                        color: ColorsManager.white,
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            date.toString().substring(8, 10),
                                            style: context.labelMedium?.copyWith(
                                              color: ColorsManager.blue56,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp,
                                            ),
                                          ),
                                          Text(
                                            month,
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
                                      decoration: BoxDecoration(
                                        color: ColorsManager.white,
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          snapshot.data!.docs[index].data().title,
                                          style: context.labelSmall?.copyWith(
                                            color: ColorsManager.black1c,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            FireStore.updateEvent(
                                              snapshot.data!.docs[index]
                                                  .data()
                                                  .id,
                                              !snapshot.data!.docs[index]
                                                  .data()
                                                  .isFave,
                                            );
                                          },
                                          icon: Icon(
                                            snapshot.data!.docs[index]
                                                    .data()
                                                    .isFave
                                                ? Icons.favorite
                                                : Icons.favorite_outline,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 15.h);
                          },
                          itemCount: snapshot.data!.docs.length,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
