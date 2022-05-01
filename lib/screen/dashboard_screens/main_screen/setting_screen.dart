import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/apis/api_services.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/widgets/our_setting_tile.dart';
import 'package:myapp/widgets/our_sized_box.dart';

import '../../../db/db_helper.dart';
import '../../../model/login_response_model.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setSp(10),
              vertical: ScreenUtil().setSp(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OurSizedBox(),
                Center(
                  child: CircleAvatar(
                    radius: ScreenUtil().setSp(50),
                    backgroundImage: AssetImage(
                      "assets/images/profile.jpg",
                    ),
                  ),
                ),
                OurSizedBox(),
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box<loginResponse>(DatabaseHelper.userdetailDB)
                          .listenable(),
                  builder: (context, Box<loginResponse> userdetail, child) {
                    // List<int> keys = userdetail.keys.cast<int>().toList();
                    // final int key = keys[0];
                    final loginResponse userdetailss = userdetail.get(1)!;

                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setSp(10),
                        vertical: ScreenUtil().setSp(10),
                      ),
                      child: Text(
                        "${userdetailss.userName ?? ""}",
                        style: TextStyle(fontSize: ScreenUtil().setSp(20)),
                      ),
                    );
                  },
                ),
                OurSizedBox(),
                OurSettingTile(
                  function: () {
                    print("button 1 pressed");
                  },
                  title: "Category",
                  icon: Icons.category_outlined,
                ),
                OurSettingTile(
                  function: () {
                    print("button 2 pressed");
                  },
                  title: "History",
                  icon: Icons.history_outlined,
                ),
                OurSettingTile(
                  function: () {
                    print("button 3 pressed");
                  },
                  title: "Favourite",
                  icon: Icons.favorite_outline,
                ),
                OurSettingTile(
                  function: () {
                    print("button 4 pressed");
                  },
                  title: "Payment",
                  icon: Icons.payment_outlined,
                ),
                OurSettingTile(
                  function: () {
                    print("button 5 pressed");
                  },
                  title: "Help and support",
                  icon: Icons.help_center_outlined,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        logoColor,
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setSp(7.5),
                          vertical: ScreenUtil().setSp(7.5),
                        ),
                      )),
                  onPressed: () async {
                    await APIService().logout(context);
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
