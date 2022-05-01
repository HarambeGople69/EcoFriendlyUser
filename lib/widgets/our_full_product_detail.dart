import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/model/product_model.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/widgets/our_description_tile.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_sized_box.dart';

class OurFullProductDetail extends StatefulWidget {
  final ProductModalClass snapshot;

  const OurFullProductDetail({Key? key, required this.snapshot})
      : super(key: key);

  @override
  State<OurFullProductDetail> createState() => _OurFullProductDetailState();
}

class _OurFullProductDetailState extends State<OurFullProductDetail> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.snapshot.productname ?? "",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(22.5),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.symmetric(
          //   horizontal: ScreenUtil().setSp(10),
          //   vertical: ScreenUtil().setSp(10),
          // ),

          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  // margin: EdgeInsets.symmetric(
                  //   horizontal: ScreenUtil().setSp(20),
                  //   vertical: ScreenUtil().setSp(10),
                  // ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        ScreenUtil().setSp(35),
                      ),
                      topRight: Radius.circular(
                        ScreenUtil().setSp(35),
                      ),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setSp(10),
                      right: ScreenUtil().setSp(10),
                      bottom: ScreenUtil().setSp(10),
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OurDescriptionTile(
                            label: "Product name:",
                            info: widget.snapshot.productname ?? "",
                          ),
                          OurDescriptionTile(
                            label: "Price:",
                            info: widget.snapshot.listprice ?? "",
                          ),
                          OurSizedBox(),
                          OurDescriptionTile(
                            label: "Description:",
                            info: widget.snapshot.description ?? "",
                          ),
                          OurSizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(logoColor),
                                ),
                                onPressed: () {
                                  if (quantity >= 2) {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: ScreenUtil().setSp(25),
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setSp(10),
                              ),
                              Text(
                                "$quantity",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(20),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setSp(10),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(logoColor),
                                ),
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                child: Icon(
                                  Icons.add,
                                  size: ScreenUtil().setSp(25),
                                ),
                              ),
                            ],
                          ),
                          OurSizedBox(),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(logoColor),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setSp(15),
                                    vertical: ScreenUtil().setSp(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                // setState(() {
                                //   quantity++;
                                // });
                              },
                              child: Text(
                                "Add to cart",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(20),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Center(
                  child: Image.asset(
                    "assets/images/1.png",
                    width: ScreenUtil().setSp(225),
                    height: ScreenUtil().setSp(200),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
