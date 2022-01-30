import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/dashboard_controller.dart';
import 'package:myapp/screen/dashboard_screens/add_product_screen/add_product_screens.dart';
import 'package:myapp/screen/dashboard_screens/chat_screens/chat_screen.dart';
import 'package:myapp/screen/dashboard_screens/main_screen/home_screen.dart';
import 'package:myapp/screen/dashboard_screens/order_screens/order_screen.dart';

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
    ChatScreen(),
    OrderScreen(),
    AddProductScreen()
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
                icon: Icon(Icons.apps),
                title: Text('Home'),
                activeColor: Colors.red,
              ),
              BottomNavyBarItem(
                  icon: Icon(Icons.people),
                  title: Text('Users'),
                  activeColor: Colors.purpleAccent),
              BottomNavyBarItem(
                  icon: Icon(Icons.message),
                  title: Text('Messages'),
                  activeColor: Colors.pink),
              BottomNavyBarItem(
                  icon: Icon(Icons.settings),
                  title: Text('Settings'),
                  activeColor: Colors.blue),
            ],
          ));
    });
  }
}
