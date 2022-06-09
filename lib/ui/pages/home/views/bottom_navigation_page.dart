import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';
import 'package:step_counter/ui/pages/home/views/home_page.dart';
import 'package:step_counter/ui/pages/home/views/work_page.dart';

import '../../../../core/constants/texts.dart';
import 'friend_list_page.dart';
import 'profile_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedItemPosition = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const WorkPage(),
    const FriendListPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedItemPosition = index;
    });
  }

  final AppColors appColors = AppColors();
  final AppTexts appTexts = AppTexts();

  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = EdgeInsets.zero;

  SnakeShape snakeShape = SnakeShape.rectangle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(7.w),
            topRight: Radius.circular(7.w),
          ),
        ),
        padding: padding,
        snakeViewColor: appColors.ovalYellow,
        elevation: 12,
        unselectedItemColor: appColors.startBlue,
        currentIndex: _selectedItemPosition,
        onTap: _onItemTapped,
        selectedItemColor: appColors.endBlue,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(
            color: appColors.blackColor,
            fontSize: 9.sp,
            fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(
            color: appColors.blackColor,
            fontSize: 9.sp,
            fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            label: appTexts.home,
            icon: const Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: appTexts.work,
            icon: const Icon(Icons.fitness_center),
          ),
          BottomNavigationBarItem(
            label: appTexts.chat,
            icon: const Icon(Icons.chat_bubble_rounded),
          ),
          BottomNavigationBarItem(
            label: appTexts.profile,
            icon: const Icon(CupertinoIcons.person),
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedItemPosition),
      ),
    );
  }
}
