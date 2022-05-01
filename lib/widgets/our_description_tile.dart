import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OurDescriptionTile extends StatelessWidget {
  final String label;
  final String info;
  const OurDescriptionTile({
    Key? key,
    required this.label,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: ScreenUtil().setSp(5),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(17),
                  fontWeight: FontWeight.w400,
                ),
                // style: normalboldText,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                info,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(18.5),
                    fontWeight: FontWeight.w500),
                // style: normalBlack,
              ),
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtil().setSp(5),
        ),
        Divider(),
      ],
    );
  }
}
