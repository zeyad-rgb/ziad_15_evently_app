import 'package:easy_localization/easy_localization.dart';
import 'package:evently_v2/core/cashing/cashing.dart';
import 'package:evently_v2/core/colors/colors_manager.dart';
import 'package:evently_v2/core/routes/routes_manager.dart';
import 'package:evently_v2/screens/event/event_screen.dart';
import 'package:evently_v2/screens/home/home_screen.dart';
import 'package:evently_v2/screens/love/love_screen.dart';
import 'package:evently_v2/screens/map/map_screen.dart';
import 'package:evently_v2/screens/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Widget> tabs = [
    HomeScreen(),
    MapScreen(),
    LoveScreen(),
    ProfileScreen(),
  ];
  bool isDark = Cashing.getTheme();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatingActionButton(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: tabs[currentIndex],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      padding: EdgeInsets.zero,
      notchMargin: 4,
      elevation: 0,
      shape: CircularNotchedRectangle(),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: [
          _buildBottomNavigationBarItem(
            currentIndex == 0 ? Icons.home : Icons.home_outlined,
            "home".tr(),
          ),
          _buildBottomNavigationBarItem(
            currentIndex == 1 ? Icons.location_on : Icons.location_on_outlined,
            "map".tr(),
          ),
          _buildBottomNavigationBarItem(
            currentIndex == 2 ? Icons.favorite : Icons.favorite_outline,
            "love".tr(),
          ),
          _buildBottomNavigationBarItem(
            currentIndex == 3 ? Icons.person : Icons.person_outlined,
            "profile".tr(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(
          color: isDark ? ColorsManager.whiteF4 : ColorsManager.white,
          width: 8.w
        )
      ),
      child: FloatingActionButton(

        onPressed: () =>
            Navigator.pushNamed(context, RoutesManager.addEventScreen),
        child: Icon(
          Icons.add,
          color: isDark ? ColorsManager.whiteF4 : ColorsManager.white,
          size: 40,
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    IconData iconPath,
    String lable,
  ) => BottomNavigationBarItem(icon: Icon(iconPath), label: lable);
}
