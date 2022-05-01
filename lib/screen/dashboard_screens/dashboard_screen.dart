import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/dashboard_controller.dart';
import 'package:myapp/screen/dashboard_screens/main_screen/home_screen.dart';
import 'package:myapp/screen/dashboard_screens/main_screen/search_screen.dart';
import 'package:myapp/screen/dashboard_screens/main_screen/setting_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List screens = [
    HomeScreen(),
    // const FavoriteScreen(),
    // const OrderScreen(),
    SearchPage(),
    Center(
      child: Text(
        "Order Screen",
      ),
    ),
    SettingScreen(),
    // const AddProductScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          body: screens[Get.find<DashboardController>().indexs.value],
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: Get.find<DashboardController>().indexs.value,
            showElevation: true, // use this to remove appBar's elevation
            onItemSelected: (index) =>
                Get.find<DashboardController>().changeIndexs(index),
            items: [
              BottomNavyBarItem(
                icon: Icon(
                  Icons.apps,
                  size: ScreenUtil().setSp(25),
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(17.5),
                  ),
                ),
                activeColor: Colors.red,
              ),
              BottomNavyBarItem(
                  icon: Icon(
                    Icons.search,
                    size: ScreenUtil().setSp(25),
                  ),
                  title: Text(
                    'Search',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(17.5),
                    ),
                  ),
                  activeColor: Colors.purpleAccent),
              BottomNavyBarItem(
                  icon: Icon(
                    Icons.shopping_bag,
                    size: ScreenUtil().setSp(25),
                  ),
                  title: Text(
                    'Orders',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(17.5),
                    ),
                  ),
                  activeColor: Colors.pink),
              BottomNavyBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: ScreenUtil().setSp(25),
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(17.5),
                    ),
                  ),
                  activeColor: Colors.blue),
            ],
          ));
    });
  }
}
