import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/model/firebase_user_model.dart';
import 'package:myapp/model/product_model.dart';
import 'package:myapp/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myapp/widgets/our_detail_product.dart';
import 'package:myapp/widgets/our_shimmer_text.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:badges/badges.dart';

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

// Badge(
//               position: BadgePosition.topStart(),
//               badgeContent: Text(
//                 "1",
//                 style: TextStyle(
//                   fontSize: ScreenUtil().setSp(15),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               child: Icon(
//                 Icons.shopping_basket,
//                 size: ScreenUtil().setSp(
//                   25,
//                 ),
//               ),
//             ),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: logoColor,
        title: const Text(
          "Eco-Friendly Paper Bag",
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: ScreenUtil().setSp(10),
            ),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Icon(
                    Icons.shopping_basket,
                    size: ScreenUtil().setSp(
                      25,
                    ),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data!.exists) {
                    FirebaseUserModel firebaseUserModel =
                        FirebaseUserModel.fromMap(snapshot.data!.data()!);
                    return Badge(
                      position: BadgePosition.topStart(),
                      badgeContent: Text(
                        firebaseUserModel.cartItemNo.toString(),
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Icon(
                        Icons.shopping_basket,
                        size: ScreenUtil().setSp(
                          25,
                        ),
                      ),
                    );
                  } else {
                    return Icon(
                      Icons.shopping_basket,
                      size: ScreenUtil().setSp(
                        25,
                      ),
                    );
                  }
                }
                return Icon(
                  Icons.shopping_basket,
                  size: ScreenUtil().setSp(
                    25,
                  ),
                );
              },
            ),
          )
        ],
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
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Products")
                        .orderBy("timestamp", descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        if (snapshot.data!.docs.length > 0) {
                          return StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 4,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              ProductModel productModel = ProductModel.fromMap(
                                  snapshot.data!.docs[index]);
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                      OurDetailProductScreen(
                                        productModelUID: productModel,
                                      ),
                                      transition: Transition.rightToLeft);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setSp(10),
                                    vertical: ScreenUtil().setSp(5),
                                  ),
                                  color: logoColor.withOpacity(0.3),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: CachedNetworkImage(
                                              height: ScreenUtil().setSp(150),
                                              width: ScreenUtil().setSp(150),
                                              fit: BoxFit.fitWidth,
                                              imageUrl: productModel.url,
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                "assets/images/placeholder.png",
                                                height: ScreenUtil().setSp(150),
                                                width: ScreenUtil().setSp(150),
                                              ),
                                            ),
                                          ),
                                          const OurSizedBox(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Name:",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      ScreenUtil().setSp(17.5),
                                                ),
                                              ),
                                              SizedBox(
                                                width: ScreenUtil().setSp(
                                                  15,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  productModel.name,
                                                  style: TextStyle(
                                                    fontSize:
                                                        ScreenUtil().setSp(15),
                                                  ),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                          const OurSizedBox(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Price:",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      ScreenUtil().setSp(17.5),
                                                ),
                                              ),
                                              SizedBox(
                                                width: ScreenUtil().setSp(
                                                  15,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  productModel.price.toString(),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          Center(
                                            child: RatingStars(
                                              value: productModel.rating
                                                  .toDouble(),
                                              starBuilder: (index, color) =>
                                                  Icon(
                                                Icons.star,
                                                color: color,
                                                size: ScreenUtil().setSp(17),
                                              ),
                                              starCount: 5,
                                              starSize: ScreenUtil().setSp(17),
                                              valueLabelColor:
                                                  const Color(0xff9b9b9b),
                                              valueLabelTextStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                              ),
                                              valueLabelRadius:
                                                  ScreenUtil().setSp(20),
                                              maxValue: 5,
                                              starSpacing: 1,
                                              maxValueVisibility: true,
                                              valueLabelVisibility: true,
                                              animationDuration: const Duration(
                                                  milliseconds: 1000),
                                              valueLabelPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: ScreenUtil().setSp(5),
                                                horizontal:
                                                    ScreenUtil().setSp(5),
                                              ),
                                              valueLabelMargin: EdgeInsets.only(
                                                right: ScreenUtil().setSp(3),
                                              ),
                                              starOffColor:
                                                  const Color(0xffe7e8ea),
                                              starColor: Colors.yellow,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (int index) =>
                                StaggeredTile.count(2, index.isEven ? 3 : 3.5),
                            mainAxisSpacing: ScreenUtil().setSp(10),
                            crossAxisSpacing: ScreenUtil().setSp(10),
                          );
                        } else {
                          return Text("No Data");
                        }
                      } else if (!snapshot.hasData) {
                        return Text("No Datasaiii");
                      }
                      return Text("data");

                      // return CircularProgressIndicator();
                      // rethrow
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
