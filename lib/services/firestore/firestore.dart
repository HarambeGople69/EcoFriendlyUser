import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:myapp/controller/authentication_controller.dart';
import 'package:myapp/db/db_helper.dart';
import 'package:myapp/model/product_model.dart';

import 'package:myapp/model/user_model.dart';
import 'package:myapp/screen/dashboard_screens/dashboard_screen.dart';
import 'package:myapp/screen/dashboard_screens/main_screen/home_screen.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';
import 'package:uuid/uuid.dart';

class Firestore {
  addUser(UserModel userModel, String url) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "email": userModel.email,
        "name": userModel.name,
        "AddedOn": DateFormat('yyy-MM-dd').format(
          DateTime.now(),
        ),
        "password": userModel.password,
        "imageUrl": url,
        "phone": userModel.phone,
        "location": userModel.location,
      }).then((value) {
        print("Done ==========================");
        Get.find<AuthenticationController>().toggle(false);
        Hive.box<int>(authenticationDB).put("state", 1);
        Get.off(DashBoardScreen());
      });
    } catch (e) {
      print(e);
      OurToast().showErrorToast(e.toString());
      Get.find<AuthenticationController>().toggle(false);
    }
  }

  addProduct(String name, String desc, double price, String url) async {
    String uid = Uuid().v4();
    try {
      await FirebaseFirestore.instance.collection("Products").doc(uid).set({
        "uid": uid,
        "name": name,
        "desc": desc,
        "price": price,
        "rating": 0.0,
        "url": url,
        "addedOn": DateFormat('yyy-MM-dd').format(
          DateTime.now(),
        ),
        "ratingUID": [],
        "ratingNo": 0,
        "timestamp": Timestamp.now(),
      }).then((value) {
        OurToast().showSuccessToast("Product added");
      });
    } catch (e) {
      OurToast().showErrorToast(e.toString());
    }
  }

  addReview(String review, String productId, String name) async {
    String uid = Uuid().v4();
    try {
      await FirebaseFirestore.instance
          .collection("Products")
          .doc(productId)
          .collection("Reviews")
          .doc(uid)
          .set({
        "uid": uid,
        "senderName": name,
        "senderId": FirebaseAuth.instance.currentUser!.uid,
        "review": review,
        "timestamp": Timestamp.now(),
      });
    } catch (e) {
      OurToast().showErrorToast(
        e.toString(),
      );
    }
  }

  addRating(ProductModel product, double rating) async {
    try {
      await FirebaseFirestore.instance
          .collection("Rating")
          .doc(product.uid)
          .collection("Ratings")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"rating": rating}).then(
        (value) => print("Inside Add rating function done"),
      );
    } catch (e) {}
  }

  updateRatingNo(ProductModel product) async {
    try {
      await FirebaseFirestore.instance
          .collection("Products")
          .doc(product.uid)
          .update({
        "ratingUID":
            FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
        "ratingNo": product.ratingNo + 1,
      }).then((value) => print("Inside UpdateRatingNo done"));
    } catch (e) {}
  }

  updateProductRating(ProductModel product) async {
    double finalRating = 0.0;
    int totalNum = 0;
    QuerySnapshot abc = await FirebaseFirestore.instance
        .collection("Rating")
        .doc(product.uid)
        .collection("Ratings")
        .get();

    abc.docs.forEach((element) {
      finalRating = finalRating + element["rating"];
    });

    var b = await FirebaseFirestore.instance
        .collection("Products")
        .doc(product.uid)
        .get();
    totalNum = b["ratingNo"];
    try {
      await FirebaseFirestore.instance
          .collection("Products")
          .doc(product.uid)
          .update({"rating": finalRating / totalNum}).then(
              (value) => print("Inside UpdateRatingNo done"));
    } catch (e) {}
  }
}
