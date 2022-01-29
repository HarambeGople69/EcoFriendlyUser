import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myapp/widgets/our_shimmer_text.dart';
import 'package:myapp/widgets/our_sized_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: logoColor,
        title: Text(
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
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                OurSizedBox(),
                OurShimmerText(
                  title: "Products",
                ),
                OurSizedBox(),
                StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.pink.withOpacity(0.3),
                      child: Image.asset(
                        items[index],
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) =>
                      StaggeredTile.count(2, index.isEven ? 2.7 : 3.5),
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
