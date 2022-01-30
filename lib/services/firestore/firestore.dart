import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:myapp/controller/authentication_controller.dart';
import 'package:myapp/db/db_helper.dart';

import 'package:myapp/model/user_model.dart';
import 'package:myapp/screen/dashboard_screens/main_screen/home_screen.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';

class Firestore {
  addUser(UserModel userModel, String url) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "email": userModel.email,
        "name": userModel.location,
        "AddedOn": DateFormat('yyy-MM-dd').format(
          DateTime.now(),
        ),
        "password": userModel.password,
        "imageUrl": "",
        "phone": userModel.phone,
        "location": userModel.location,
      }).then((value) {
        print("Done ==========================");
        Get.find<AuthenticationController>().toggle(false);
        Hive.box<int>(authenticationDB).put("state", 1);
        Get.off(HomeScreen());
      });
    } catch (e) {
      print(e);
      OurToast().showErrorToast(e.toString());
      Get.find<AuthenticationController>().toggle(false);
    }
  }
}
