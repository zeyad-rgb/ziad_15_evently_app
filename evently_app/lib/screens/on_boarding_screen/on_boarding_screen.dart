import 'package:easy_localization/easy_localization.dart';
import 'package:evently_v2/core/assets/assets_manager.dart';
import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:evently_v2/core/extension/build_context_extension.dart';
import 'package:evently_v2/core/models/on_boarding_model.dart';
import 'package:evently_v2/core/routes/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  List<OnBoardingModel> boardList = [
    OnBoardingModel(
      imagePath: PngAssets.imageBoard1,
      title: "onboarding_title1".tr(),
      description: "onboarding_subtitle1".tr(),
    ),
    OnBoardingModel(
      imagePath: PngAssets.imageBoard2,
      title: "onboarding_title2".tr(),
      description: "onboarding_subtitle2".tr(),
    ),
    OnBoardingModel(
      imagePath: PngAssets.imageBoard3,
      title: "onboarding_title3".tr(),
      description: "onboarding_subtitle3".tr(),
    ),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset(PngAssets.logoH), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (value) => setState(() {
                  currentIndex = value;
                }),
                itemCount: boardList.length,
                itemBuilder: (context, index) => _buildOnBoardingItem(
                  boardList[index].imagePath,
                  boardList[index].title,
                  boardList[index].description,
                  context,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorsManager.blue56),
                      shape: BoxShape.circle,
                    ),
                    child: currentIndex > 0
                        ? IconButton(
                            onPressed: () {
                              pageController.previousPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.linear,
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: ColorsManager.blue56,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                RoutesManager.introScreen,
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: ColorsManager.blue56,
                            ),
                          ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 5),
                      CustomIndicator(active: currentIndex == 0),
                      SizedBox(width: 5),
                      CustomIndicator(active: currentIndex == 1),
                      SizedBox(width: 5),
                      CustomIndicator(active: currentIndex == 2),
                      SizedBox(width: 5),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorsManager.blue56),
                      shape: BoxShape.circle,
                    ),
                    child: currentIndex < 2
                        ? IconButton(
                            onPressed: () {
                              pageController.nextPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.linear,
                              );
                            },
                            icon: Icon(
                              Icons.arrow_forward,
                              color: ColorsManager.blue56,
                            ),
                          )
                        : IconButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('onboarding_seen', true);
                              Navigator.pushReplacementNamed(
                                context,
                                RoutesManager.loginScreen,
                              );
                            },
                            icon: Icon(
                              Icons.arrow_forward,
                              color: ColorsManager.blue56,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildOnBoardingItem(
  String image,
  String title,
  String description,
  BuildContext context,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(child: Image.asset(image)),
      SizedBox(height: 30.h),
      Text(
        textDirection: Directionality.of(context),
        title,
        style: context.labelMedium?.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w800,
        ),
      ),
      SizedBox(height: 30.h),
      Text(
        textDirection: Directionality.of(context),
        description,

        style: context.labelSmall?.copyWith(fontWeight: FontWeight.w600),
      ),
    ],
  );
}

class CustomIndicator extends StatelessWidget {
  final bool active;

  const CustomIndicator({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: active ? ColorsManager.blue56 : ColorsManager.grey7B,
        borderRadius: BorderRadius.circular(50.r),
      ),
      width: active ? 20.w : 8.w,
      height: 8.h,
      duration: Duration(milliseconds: 300),
    );
  }
}
