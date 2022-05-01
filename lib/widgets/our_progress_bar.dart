import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myapp/utils/colors.dart';

class OurProgressBar extends StatelessWidget {
  const OurProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      size: ScreenUtil().setSp(60),
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? logoColor : Colors.green,
          ),
        );
      },
    );
  }
}
