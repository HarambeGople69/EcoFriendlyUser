import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/model/cart_product_model.dart';
import 'package:myapp/services/firestore/firestore.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:timeago/timeago.dart' as timeago;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: ScreenUtil().setSp(25),
          ),
        ),
        backgroundColor: logoColor,
        centerTitle: true,
        title: Text(
          "My Cart",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(25),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setSp(20),
            vertical: ScreenUtil().setSp(10),
          ),
          child: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Carts")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("Products")
                  .orderBy(
                    "addedOn",
                    descending: true,
                  )
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  if (snapshot.data!.docs.length > 0) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          CartProductModel cartProductModel =
                              CartProductModel.fromMap(
                                  snapshot.data!.docs[index]);
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: CachedNetworkImage(
                                            height: ScreenUtil().setSp(150),
                                            width: ScreenUtil().setSp(150),
                                            fit: BoxFit.fitWidth,
                                            imageUrl: cartProductModel.url,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              "assets/images/placeholder.png",
                                              height: ScreenUtil().setSp(150),
                                              width: ScreenUtil().setSp(150),
                                            ),
                                          ),
                                        ),
                                        OurSizedBox(),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    ScreenUtil().setSp(20),
                                              ),
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().setSp(17.5),
                                            ),
                                            Expanded(
                                              child: Text(
                                                cartProductModel.name,
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(17.5),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        OurSizedBox(),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Price:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    ScreenUtil().setSp(20),
                                              ),
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().setSp(17.5),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "Rs. ${cartProductModel.price.toString()}",
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(17.5),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                              color: logoColor,
                                              onPressed: () async {
                                                if (cartProductModel.quantity >
                                                    1) {
                                                  await Firestore()
                                                      .decreaseProductCount(
                                                          cartProductModel);
                                                }
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                size: ScreenUtil().setSp(25),
                                              ),
                                            ),
                                            Text(
                                              cartProductModel.quantity
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(20),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                await Firestore()
                                                    .increaseProductCount(
                                                        cartProductModel);
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                size: ScreenUtil().setSp(25),
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await Firestore()
                                                .deleteItemFromCart(
                                                    cartProductModel);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: ScreenUtil().setSp(
                                              25,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              OurSizedBox(),
                              Divider(),
                              OurSizedBox(),
                            ],
                          );
                        });
                  } else {
                    return Text("No Data");
                  }
                }
                return Text("data");
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setSp(20),
          vertical: ScreenUtil().setSp(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: OurElevatedButton(
                title: "Clear Cart",
                function: () async {
                  await Firestore().clearCart();
                },
              ),
            ),
            SizedBox(
              width: ScreenUtil().setSp(20),
            ),
            Expanded(
              child: OurElevatedButton(
                title: "Check Out",
                function: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
