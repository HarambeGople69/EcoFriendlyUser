import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/model/product_model.dart';
import 'package:myapp/widgets/our_full_product_detail.dart';
import 'package:myapp/widgets/our_sized_box.dart';

class OurProductTile extends StatelessWidget {
  final ProductModalClass snapshot;
  const OurProductTile({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OurFullProductDetail(snapshot: snapshot);
        }));
        // print(snapshot.productname);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setSp(10),
          vertical: ScreenUtil().setSp(10),
        ),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(
            ScreenUtil().setSp(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.favorite_border_outlined,
                color: Colors.red,
              ),
            ),
            Center(
              child: Image.asset(
                "assets/images/1.png",
                width: ScreenUtil().setSp(125),
                height: ScreenUtil().setSp(125),
                fit: BoxFit.contain,
                
              ),
            ),
            Text(
              snapshot.productname ?? "",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(16.5),
              ),
              overflow: TextOverflow.fade,
            ),
            OurSizedBox(),
            Text(
              snapshot.listprice ?? "",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
