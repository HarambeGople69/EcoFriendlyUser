import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:myapp/apis/api_services.dart';
import 'package:myapp/model/product_model.dart';
import 'package:myapp/widgets/our_product_tile.dart';
import 'package:myapp/widgets/our_progress_bar.dart';
import '../../../controller/product_controller.dart';
import '../../../controller/search_text_controller.dart';
import '../../../db/db_helper.dart';
import '../../../utils/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ProductModalClass>? lists;
  List listMap = [];
  List<int> indexs = [];
  int canpress = 1;

  fetchFromHive() async {
    setState(() {
      listMap = [];
      indexs = [];
    });
    var Keys = Hive.box<ProductModalClass>(DatabaseHelper.productdetailDB)
        .keys
        .cast<int>()
        .toList();
    print(Keys);
    print(Keys.length);
    List abc = [];
    setState(() {
      Keys.forEach((element) {
        // abc.add(element);
        listMap.add(Hive.box<ProductModalClass>(DatabaseHelper.productdetailDB)
            .get(Keys[element])!
            .toJson());
      });
    });

    print(listMap);
    // print(abc);
  }

  searchFeature(String searchText) async {
    try {
      setState(() {
        // indexs = [];
        //   listMap = [];
      });
      // await fetchData();
      await fetchFromHive();
      print("+++++++++++");
      print(listMap);
      print(searchText);
      print("--------");
      listMap.forEach((element1) {
        // print(searchText);
        if (element1["productname"].trim() == searchText) {
          setState(() {
            indexs.add(listMap.indexOf(element1));
          });
        }
        // print(element1["productname"]);
      });
      print("===========");
      print("Here are the indexes");
      print(indexs);
      // setState(() {
      setState(() {
        canpress = 1;
        print("Changed");
      });
    } catch (e) {
      print("Error aaiyo");
    }
  }

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
              children: [
                Row(
                  children: [
                    Obx(
                      () => Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setSp(20),
                            vertical: ScreenUtil().setSp(10),
                          ),
                          height: ScreenUtil().setSp(45),
                          child: TextField(
                            onChanged: (value) {
                              Get.find<SearchTextController>()
                                  .changeValue(value);
                            },
                            style: TextStyle(
                              color: logoColor,
                              fontSize: ScreenUtil().setSp(17.5),
                            ),
                            controller: Get.find<SearchTextController>()
                                .search_controller
                                .value,
                            decoration: InputDecoration(
                              focusColor: logoColor,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: lightlogoColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    ScreenUtil().setSp(10),
                                  ),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: lightlogoColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    ScreenUtil().setSp(10),
                                  ),
                                ),
                              ),
                              hintText: "Product Name",
                              hintStyle: TextStyle(
                                color: logoColor,
                                fontSize: ScreenUtil().setSp(17.5),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.search,
                                size: ScreenUtil().setSp(25),
                                color: logoColor,
                              ),
                              suffixIcon: Get.find<SearchTextController>()
                                      .searchText
                                      .trim()
                                      .isEmpty
                                  ? Icon(null)
                                  : InkWell(
                                      onTap: () {
                                        Get.find<SearchTextController>()
                                            .clearController();
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        size: ScreenUtil().setSp(25),
                                        color: logoColor,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          searchFeature(Get.find<SearchTextController>()
                              .searchText
                              .toString());
                        },
                        icon: Icon(
                          Icons.search,
                          size: ScreenUtil().setSp(30),
                        )),
                  ],
                ),
                indexs.isEmpty
                    ? FutureBuilder(
                        future: APIService().getProduct(),
                        builder: (context, AsyncSnapshot snapshot) {
                          return snapshot.hasData
                              ? snapshot.data.length > 0
                                  ?

                                  // Text("Utsav")

                                  // ListView.builder(
                                  //     shrinkWrap: true,
                                  //     physics: const NeverScrollableScrollPhysics(),
                                  //     itemBuilder: (context, index) {
                                  //       return Text("data");
                                  //     })

                                  StaggeredGridView.countBuilder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      crossAxisCount: 4,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return OurProductTile(
                                            snapshot: snapshot.data[index]);
                                      },
                                      staggeredTileBuilder: (int index) =>
                                          StaggeredTile.count(
                                              2, index.isEven ? 3 : 3),
                                      mainAxisSpacing: ScreenUtil().setSp(10),
                                      crossAxisSpacing: ScreenUtil().setSp(10),
                                    )
                                  : Text("data1")
                              : Center(
                                  child: OurProgressBar(),
                                );
                        })
                    : StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        itemCount: indexs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return OurProductTile(
                              snapshot: Hive.box<ProductModalClass>(
                                      DatabaseHelper.productdetailDB)
                                  .get(indexs[index])!);
                        },
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.count(2, index.isEven ? 3 : 3),
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
