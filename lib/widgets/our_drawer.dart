import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/apis/api_services.dart';
import 'package:myapp/widgets/our_elevated_button.dart';

class OurDrawer extends StatefulWidget {
  const OurDrawer({Key? key}) : super(key: key);

  @override
  State<OurDrawer> createState() => _OurDrawerState();
}

class _OurDrawerState extends State<OurDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text("Dummy title 1"),
          ),
          ListTile(
            title: Text("Dummy title 1"),
          ),
          ListTile(
            title: Text("Dummy title 1"),
          ),
          ListTile(
            title: Text("Dummy title 1"),
          ),
          ListTile(
            title: Text("Dummy title 1"),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setSp(5),
              vertical: ScreenUtil().setSp(5),
            ),
            child: OurElevatedButton(
              title: "Logout",
              function: () {
                APIService().logout(context);
              },
            ),
          ),
        ],
      )),
    );
  }
}
