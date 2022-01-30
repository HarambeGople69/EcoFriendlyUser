import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myapp/widgets/our_shimmer_text.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double value = 3.5;
  List items = [
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png",
    "assets/images/5.png",
    "assets/images/6.png",
    "assets/images/7.png",
    "assets/images/8.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: logoColor,
        title: const Text(
          "Eco-Friendly Paper Bag",
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(10),
            vertical: ScreenUtil().setSp(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: ScreenUtil().setSp(150),
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    // onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    "assets/images/1.png",
                    "assets/images/2.png",
                    "assets/images/3.png",
                    "assets/images/4.png",
                    "assets/images/5.png",
                    "assets/images/6.png",
                    "assets/images/7.png",
                    "assets/images/8.png",
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: Image.asset(
                            i,
                            height: ScreenUtil().setSp(100),
                            width: ScreenUtil().setSp(100),
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const OurSizedBox(),
                const OurShimmerText(
                  title: "Products",
                ),
                const OurSizedBox(),
                StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setSp(10),
                        vertical: ScreenUtil().setSp(5),
                      ),
                      color: logoColor.withOpacity(0.3),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.asset(
                                  items[index],
                                  height: ScreenUtil().setSp(150),
                                  width: ScreenUtil().setSp(150),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              const OurSizedBox(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Name:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(17.5),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setSp(
                                      15,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Item $index",
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(15),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const OurSizedBox(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Price:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(17.5),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setSp(
                                      15,
                                    ),
                                  ),
                                  const Expanded(
                                    child: Text(
                                      "Rs 500",
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Center(
                                child: RatingStars(
                                  value: value,
                                  onValueChanged: (v) {
                                    setState(() {
                                      value = v;
                                    });
                                  },
                                  starBuilder: (index, color) => Icon(
                                    Icons.star,
                                    color: color,
                                    size: ScreenUtil().setSp(17),
                                  ),
                                  starCount: 5,
                                  starSize: ScreenUtil().setSp(17),
                                  valueLabelColor: const Color(0xff9b9b9b),
                                  valueLabelTextStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: ScreenUtil().setSp(12),
                                  ),
                                  valueLabelRadius: ScreenUtil().setSp(20),
                                  maxValue: 5,
                                  starSpacing: 1,
                                  maxValueVisibility: true,
                                  valueLabelVisibility: true,
                                  animationDuration:
                                      const Duration(milliseconds: 1000),
                                  valueLabelPadding: EdgeInsets.symmetric(
                                    vertical: ScreenUtil().setSp(5),
                                    horizontal: ScreenUtil().setSp(5),
                                  ),
                                  valueLabelMargin: EdgeInsets.only(
                                    right: ScreenUtil().setSp(3),
                                  ),
                                  starOffColor: const Color(0xffe7e8ea),
                                  starColor: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) =>
                      StaggeredTile.count(2, index.isEven ? 3 : 3.5),
                  mainAxisSpacing: ScreenUtil().setSp(10),
                  crossAxisSpacing: ScreenUtil().setSp(10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
