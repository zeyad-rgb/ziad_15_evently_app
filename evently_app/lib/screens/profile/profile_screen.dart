import 'package:easy_localization/easy_localization.dart';
import 'package:evently_v2/config/firebase/firebase_auth.dart';
import 'package:evently_v2/core/assets/assets_manager.dart';
import 'package:evently_v2/core/cashing/cashing.dart';
import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:evently_v2/core/extension/build_context_extension.dart';
import 'package:evently_v2/core/models/user_data.dart';
import 'package:evently_v2/core/providers/providers_manager.dart';
import 'package:evently_v2/core/providers/user_provider.dart';
import 'package:evently_v2/core/routes/routes_manager.dart';
import 'package:evently_v2/screens/profile/build_drop_down_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedLanguage = "en".tr();
  String selectedTheme = "Light";
  UserModel? user;

  @override
  void initState() {
    super.initState();
    FirebaseAuthentication.getCurrentUser().then((value) {
      if (mounted) {
        setState(() {
          user = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ProvidersManager providersManager = Provider.of<ProvidersManager>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Container(
            padding: EdgeInsets.only(
              top: 50.h,
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
            ),
            width: double.infinity,
            height: 180.h,
            decoration: BoxDecoration(
              color: ColorsManager.blue56,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
            ),
            child: Row(
              children: [
                Image.asset(PngAssets.routeImage),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        userProvider.userModel != null
                            ? userProvider.userModel!.name
                            : '...',
                        style: context.labelMedium?.copyWith(
                          color: ColorsManager.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        userProvider.userModel != null
                            ? userProvider.userModel!.email
                            : '...',
                        style: context.labelSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 44,
            top: 24,
            left: 16,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildDropDownWidget(
                textView: context.locale.languageCode == 'ar'
                    ? "ar".tr()
                    : "en".tr(),
                items: ["en".tr(), "ar".tr()],
                labelText: "language".tr(),
                onChanged: (newLanguage) {
                  setState(() {
                    selectedLanguage = newLanguage!;
                    if (selectedLanguage == "ar".tr()) {
                      context.setLocale(const Locale("ar"));
                    } else {
                      context.setLocale(const Locale("en"));
                    }
                  });
                },
              ),
              BuildDropDownWidget(
                textView: providersManager.isDark == true
                    ? "dark".tr()
                    : "light".tr(),
                items: ["dark".tr(), "light".tr()],
                labelText: "theme".tr(),

                onChanged: (newTheme) {
                  setState(() {
                    selectedTheme = newTheme!;
                    if (selectedTheme == "dark".tr()) {
                      providersManager.toggleTheme(true);
                      Cashing.saveTheme(true);
                    } else {
                      providersManager.toggleTheme(false);
                      Cashing.saveTheme(false);
                    }
                  });
                },
              ),
              SizedBox(height: 175.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.redF5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    side: BorderSide(color: ColorsManager.redF5),
                  ),
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();

                    final googleSignIn = GoogleSignIn();
                    if (await googleSignIn.isSignedIn()) {
                      await googleSignIn.signOut();
                    }

                    userProvider.clearData();

                    Navigator.pushReplacementNamed(
                      context,
                      RoutesManager.loginScreen,
                    );
                  } catch (e) {
                    // في حالة وجود خطأ
                    print("Logout Error: $e");
                  }
                },

                child: Row(
                  children: [
                    Icon(Icons.logout, size: 25.sp),
                    SizedBox(width: 10.w),
                    Text("logout".tr()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
