import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myapp/apis/api_services.dart';
import 'package:myapp/controller/product_controller.dart';
import 'package:myapp/controller/search_text_controller.dart';
import 'package:myapp/db/db_helper.dart';
import 'package:myapp/model/firebase_user_model.dart';
import 'package:myapp/model/login_response_model.dart';
import 'package:myapp/model/product_model.dart';
import 'package:myapp/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myapp/widgets/our_drawer.dart';
import 'package:myapp/widgets/our_product_list_style.dart';
import 'package:myapp/widgets/our_product_tile.dart';
import 'package:myapp/widgets/our_progress_bar.dart';
import 'package:myapp/widgets/our_shimmer_text.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:badges/badges.dart';

import '../../../widgets/our_full_product_detail.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // APIService().getProduct(context);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
  String searchText = "";
  TextEditingController _search_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: OurDrawer(),
      ),
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.menu,
            size: ScreenUtil().setSp(
              25,
            ),
          ),
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        backgroundColor: logoColor,
        title:
            //  ValueListenableBuilder(
            // valueListenable:
            //     Hive.box<loginResponse>(DatabaseHelper.userdetailDB)
            //         .listenable(),
            // builder: (context, Box<loginResponse> userdetail, child) {
            //   List<int> keys = userdetail.keys.cast<int>().toList();
            //   final int key = keys[0];
            //   final loginResponse userdetailss = userdetail.get(key)!;
            // return InkWell(
            //     onTap: () {
            //       print(userdetailss.userName);
            //     },
            //     child: Text("data"));

            // return Text("Welcome\n${userdetailss.userName ?? ""}");
            // return InkWell(
            //     onTap: () {
            //       print(userdetailss);
            //     },
            //     child: Text("data"));
            // }),
            Text(
          "FMC Cart",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(25),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(
              ScreenUtil().setSp(20),
            ),
            bottomLeft: Radius.circular(
              ScreenUtil().setSp(20),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: ScreenUtil().setSp(10),
            ),
            child: Icon(
              Icons.shopping_basket,
              size: ScreenUtil().setSp(
                25,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          child: ValueListenableBuilder(
            valueListenable:
                Hive.box<loginResponse>(DatabaseHelper.userdetailDB)
                    .listenable(),
            builder: (context, Box<loginResponse> userdetail, child) {
              // List<int> keys = userdetail.keys.cast<int>().toList();
              // final int key = keys[0];
              final loginResponse userdetailss = userdetail.get(1)!;

              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setSp(10),
                    vertical: ScreenUtil().setSp(10),
                  ),
                  child: Text(
                    "Welcome\n${userdetailss.userName ?? ""}",
                    style: TextStyle(fontSize: ScreenUtil().setSp(20)),
                  ),
                ),
              );
            },
          ),
          //  Obx(
          //   () => Container(
          //     margin: EdgeInsets.symmetric(
          //       horizontal: ScreenUtil().setSp(20),
          //       vertical: ScreenUtil().setSp(10),
          //     ),
          //     height: ScreenUtil().setSp(45),
          //     child: TextField(
          //       onChanged: (value) {
          //         Get.find<SearchTextController>().changeValue(value);
          //       },
          //       style: TextStyle(
          //         color: logoColor,
          //         fontSize: ScreenUtil().setSp(17.5),
          //       ),
          //       controller:
          //           Get.find<SearchTextController>().search_controller.value,
          //       decoration: InputDecoration(
          //         focusColor: logoColor,
          //         border: OutlineInputBorder(
          //           borderSide: BorderSide(
          //             color: lightlogoColor,
          //           ),
          //           borderRadius: BorderRadius.all(
          //             Radius.circular(
          //               ScreenUtil().setSp(10),
          //             ),
          //           ),
          //         ),
          //         focusedBorder: OutlineInputBorder(
          //           borderSide: BorderSide(
          //             color: lightlogoColor,
          //           ),
          //           borderRadius: BorderRadius.all(
          //             Radius.circular(
          //               ScreenUtil().setSp(10),
          //             ),
          //           ),
          //         ),
          //         hintText: "Product Name",
          //         hintStyle: TextStyle(
          //           color: logoColor,
          //           fontSize: ScreenUtil().setSp(17.5),
          //         ),
          //         fillColor: Colors.white,
          //         filled: true,
          //         prefixIcon: Icon(
          //           Icons.search,
          //           size: ScreenUtil().setSp(25),
          //           color: logoColor,
          //         ),
          //         suffixIcon: Get.find<SearchTextController>()
          //                 .searchText
          //                 .trim()
          //                 .isEmpty
          //             ? Icon(null)
          //             : InkWell(
          //                 onTap: () {
          //                   Get.find<SearchTextController>().clearController();
          //                 },
          //                 child: Icon(
          //                   Icons.delete,
          //                   size: ScreenUtil().setSp(25),
          //                   color: logoColor,
          //                 ),
          //               ),
          //       ),
          //     ),
          //   ),
          // ),

          preferredSize: Size.fromHeight(
            ScreenUtil().setSp(55),
          ),
        ),
      ),
      // body: Column(
      //   children: [],
      // ),
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
                          // height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: Image.asset(
                            i,
                            height: ScreenUtil().setSp(120),
                            width: ScreenUtil().setSp(120),
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
                FutureBuilder(
                    future: APIService().getProduct(),
                    builder: (context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? snapshot.data.length > 0
                              ?

                              // Text("Utsav")

                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return OurProductListStyle(
                                        snapshot: snapshot.data[index]);
                                  })

                              // StaggeredGridView.countBuilder(
                              //     shrinkWrap: true,
                              //     physics: const NeverScrollableScrollPhysics(),
                              //     crossAxisCount: 4,
                              //     itemCount: snapshot.data!.length,
                              //     itemBuilder:
                              //         (BuildContext context, int index) {
                              //       return OurProductTile(
                              //           snapshot: snapshot.data[index]);
                              //     },
                              //     staggeredTileBuilder: (int index) =>
                              //         StaggeredTile.count(
                              //             2, index.isEven ? 3 : 3),
                              //     mainAxisSpacing: ScreenUtil().setSp(10),
                              //     crossAxisSpacing: ScreenUtil().setSp(10),
                              //   )
                              : Text("data1")
                          : Center(
                              child: OurProgressBar(),
                            );
                    })
                // const OurSizedBox(),
                // const OurShimmerText(
                //   title: "Products",
                // ),
                // const OurSizedBox(),
                // Obx(() => Get.find<SearchTextController>()
                //         .searchText
                //         .trim()
                //         .isEmpty
                //     ? StreamBuilder<QuerySnapshot>(
                //         stream: FirebaseFirestore.instance
                //             .collection("Products")
                //             .orderBy("timestamp", descending: true)
                //             .snapshots(),
                //         builder:
                //             (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //           if (snapshot.connectionState ==
                //               ConnectionState.waiting) {
                //             return CircularProgressIndicator();
                //           } else if (snapshot.hasData) {
                //             if (snapshot.data!.docs.length > 0) {
                //               return StaggeredGridView.countBuilder(
                //                 shrinkWrap: true,
                //                 physics: const NeverScrollableScrollPhysics(),
                //                 crossAxisCount: 4,
                //                 itemCount: snapshot.data!.docs.length,
                //                 itemBuilder: (BuildContext context, int index) {
                //                   ProductModel productModel =
                //                       ProductModel.fromMap(
                //                           snapshot.data!.docs[index]);
                //                   return OurProductItemTile(
                //                     productModel: productModel,
                //                   );
                //                 },
                //                 staggeredTileBuilder: (int index) =>
                //                     StaggeredTile.count(
                //                         2, index.isEven ? 3.35 : 3.7),
                //                 mainAxisSpacing: ScreenUtil().setSp(10),
                //                 crossAxisSpacing: ScreenUtil().setSp(10),
                //               );
                //             } else {
                //               return Text("No Data");
                //             }
                //           } else if (!snapshot.hasData) {
                //             return Text("No Datasaiii");
                //           }
                //           return Text("data");

                //           // return CircularProgressIndicator();
                //           // rethrow
                //         },
                //       )
                //     : StreamBuilder(
                //         stream: FirebaseFirestore.instance
                //             .collection("Products")
                //             .where("searchfrom",
                //                 arrayContains: Get.find<SearchTextController>()
                //                     .search_controller
                //                     .value
                //                     .text
                //                     .toLowerCase())
                //             .snapshots(),
                //         builder: (BuildContext context,
                //             AsyncSnapshot<QuerySnapshot> snapshot) {
                //           if (snapshot.hasData) {
                //             if (snapshot.data!.docs.length > 0) {
                //               return StaggeredGridView.countBuilder(
                //                 shrinkWrap: true,
                //                 physics: const NeverScrollableScrollPhysics(),
                //                 crossAxisCount: 4,
                //                 itemCount: snapshot.data!.docs.length,
                //                 itemBuilder: (BuildContext context, int index) {
                //                   ProductModel productModel =
                //                       ProductModel.fromMap(
                //                           snapshot.data!.docs[index]);
                //                   return OurProductItemTile(
                //                     productModel: productModel,
                //                   );
                //                 },
                //                 staggeredTileBuilder: (int index) =>
                //                     StaggeredTile.count(
                //                         2, index.isEven ? 3.75 : 3.5),
                //                 mainAxisSpacing: ScreenUtil().setSp(10),
                //                 crossAxisSpacing: ScreenUtil().setSp(10),
                //               );
                //             } else {
                //               return Center(
                //                 child: Text(
                //                   "No Users",
                //                 ),
                //               );
                //             }
                //           } else {
                //             return Center(child: CircularProgressIndicator());
                //           }
                //         }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
