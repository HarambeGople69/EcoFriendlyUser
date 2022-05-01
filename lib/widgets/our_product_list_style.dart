import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/model/product_model.dart';
import 'package:myapp/widgets/our_full_product_detail.dart';

class OurProductListStyle extends StatefulWidget {
  final ProductModalClass snapshot;
  const OurProductListStyle({ Key? key,required this.snapshot }) : super(key: key);

  @override
  State<OurProductListStyle> createState() => _OurProductListStyleState();
}

class _OurProductListStyleState extends State<OurProductListStyle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return OurFullProductDetail(
                                            snapshot: widget.snapshot,
                                          );
                                        }));
                                        // print(snapshot.productname);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: ScreenUtil().setSp(10),
                                          vertical: ScreenUtil().setSp(10),
                                        ),
                                        margin: EdgeInsets.symmetric(
                                          horizontal: ScreenUtil().setSp(10),
                                          vertical: ScreenUtil().setSp(10),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(
                                            ScreenUtil().setSp(15),
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Image.asset(
                                                "assets/images/1.png",
                                                width: ScreenUtil().setSp(125),
                                                height: ScreenUtil().setSp(125),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().setSp(15),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget.snapshot
                                                            .productname ??
                                                        "",
                                                    style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(16.5),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                  // snapshot.data[index]
                                                  //             .productname
                                                  //             ==
                                                  //         " "
                                                  //     ? Text("adf")
                                                  //     : OurSizedBox(),
                                                  SizedBox(
                                                    height: ScreenUtil().setSp(
                                                      7.5,
                                                    ),
                                                  ),
                                                  Text(
                                                    widget.snapshot
                                                            .description ??
                                                        "",
                                                    style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(12.5),
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: ScreenUtil().setSp(
                                                      7.5,
                                                    ),
                                                  ),
                                                  Text(
                                                    widget.snapshot
                                                            .listprice ??
                                                        "",
                                                    style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(15),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.favorite_border,
                                              color: Colors.red,
                                              size: ScreenUtil().setSp(25),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
  }
}