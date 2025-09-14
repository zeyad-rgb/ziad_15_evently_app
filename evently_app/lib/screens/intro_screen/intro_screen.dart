import 'package:easy_localization/easy_localization.dart';
import 'package:evently_v2/core/assets/assets_manager.dart';
import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:evently_v2/core/extension/build_context_extension.dart';
import 'package:evently_v2/core/providers/providers_manager.dart';
import 'package:evently_v2/core/routes/routes_manager.dart';
import 'package:evently_v2/core/widgets/custome_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    ProvidersManager providersManager = Provider.of<ProvidersManager>(context);
    final isDark = providersManager.isDark;
    return Scaffold(
      appBar: AppBar(title: Image.asset(PngAssets.logoH), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24.h,
          children: [
            SizedBox(),
            Center(child: Image.asset(PngAssets.introBg)),
            Text(
              "introduction_title".tr(),
              style: context.labelMedium?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "introduction_subtitle".tr(),
              style: context.labelSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "language".tr(),
                  style: context.labelMedium?.copyWith(
                    color: Theme.of(context).primaryColor,

                    fontWeight: FontWeight.bold,
                  ),
                ),
                Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      spacing: 15.w,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.setLocale(Locale('en'));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: context.locale.toString() == 'en'
                                    ? Theme.of(context).primaryColor
                                    : ColorsManager.transparent,
                                width: 5.w,
                              ),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: SvgPicture.asset(
                              SvgAssets.usLogo,
                              width: 30.w,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.setLocale(Locale('ar'));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: context.locale.toString() == 'ar'
                                    ? Theme.of(context).primaryColor
                                    : ColorsManager.transparent,
                                width: 5.w,
                              ),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: SvgPicture.asset(
                              SvgAssets.egLogo,
                              width: 30.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "theme".tr(),
                  style: context.labelMedium?.copyWith(
                    color: Theme.of(context).primaryColor,

                    fontWeight: FontWeight.bold,
                  ),
                ),
                Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorsManager.blue56,
                        width: 2.w,
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Row(
                      spacing: 15.w,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            providersManager.toggleTheme(false);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? ColorsManager.transparent
                                  : Theme.of(context).primaryColor,
                              border: Border.all(
                                color: isDark
                                    ? ColorsManager.transparent
                                    : Theme.of(context).primaryColor,
                                width: 5.w,
                              ),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Icon(
                              Icons.light_mode,
                              color: isDark
                                  ? Theme.of(context).primaryColor
                                  : ColorsManager.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            providersManager.toggleTheme(true);
                          },

                          child: Container(
                            decoration: BoxDecoration(
                              color: !isDark
                                  ? ColorsManager.transparent
                                  : Theme.of(context).primaryColor,
                              border: Border.all(
                                color: !isDark
                                    ? ColorsManager.transparent
                                    : Theme.of(context).primaryColor,
                                width: 5.w,
                              ),
                              borderRadius: BorderRadius.circular(30.r),
                            ),

                            child: Icon(
                              Icons.dark_mode,
                              color: !isDark
                                  ? Theme.of(context).primaryColor
                                  : ColorsManager.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            CustomeElevatedButton(
              label: "intro_btn".tr(),
              onPressed: () async{
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('introScreen_seen', true);
                Navigator.pushReplacementNamed(
                  context,
                  RoutesManager.onBoardingScreen,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
