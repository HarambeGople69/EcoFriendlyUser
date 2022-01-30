import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_sized_box.dart';

class OurDetailProductScreen extends StatefulWidget {
  final String imageUrl;
  const OurDetailProductScreen({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _OurDetailProductScreenState createState() => _OurDetailProductScreenState();
}

class _OurDetailProductScreenState extends State<OurDetailProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: Container(
            // margin: EdgeInsets.symmetric(
            //   horizontal: ScreenUtil().setSp(10),
            //   vertical: ScreenUtil().setSp(10),
            // ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Colors.grey.withOpacity(0.3),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Image.asset(
                            widget.imageUrl,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setSp(10),
                          vertical: ScreenUtil().setSp(10),
                        ),
                        height: ScreenUtil().setSp(40),
                        width: ScreenUtil().setSp(40),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: ScreenUtil().setSp(25),
                          ),
                        ),
                      ),
                    ],
                  ),
                  OurSizedBox(),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setSp(20),
                      vertical: ScreenUtil().setSp(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "data",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setSp(20),
          vertical: ScreenUtil().setSp(10),
        ),
        child: OurElevatedButton(
          title: "Add to Cart",
          function: () {},
        ),
      ),
    );
  }
}
