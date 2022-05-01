import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OurSettingTile extends StatefulWidget {
  final Function function;
  final String title;
  final IconData icon;
  const OurSettingTile(
      {Key? key,
      required this.function,
      required this.title,
      required this.icon})
      : super(key: key);

  @override
  State<OurSettingTile> createState() => _OurSettingTileState();
}

class _OurSettingTileState extends State<OurSettingTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        widget.function();
      },
      leading: Icon(
        widget.icon,
        size: ScreenUtil().setSp(22.5),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(17),
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: ScreenUtil().setSp(20),
      ),
    );
  }
}
