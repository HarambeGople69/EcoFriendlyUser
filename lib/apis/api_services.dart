import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/db/db_helper.dart';
import 'package:myapp/model/product_model.dart';
import 'package:myapp/screen/dashboard_screens/dashboard_screen.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_response_model.dart';
import '../screen/authentication_screen/login_screen.dart';
import '../screen/dashboard_screens/main_screen/home_screen.dart';

class APIService {
  Future<bool> saveUserAuth(loginResponse loginresponse) async {
    // Hive.box<loginResponse>(DatabaseHelper.userdetailDB).clear();
    // Hive.box<loginResponse>(userdetailDB).clear();
    print(loginresponse.toJson());
    Hive.box<loginResponse>(DatabaseHelper.userdetailDB).put(
      1,
      loginResponse.fromJson(
        loginresponse.toJson(),
      ),
    );
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("token", loginresponse.token ?? "");
    return true;
  }

  Future<void> login(Map<String, dynamic> toJson, BuildContext context) async {
    print("Inside login");
    String url = "https://api.fmccart.com/client/mobauth";
    try {
      final response = await http.post(Uri.parse(url), body: (toJson));
      if (response.statusCode == 200) {
        print("Inside 200 code");
        var responseJson = json.decode(response.body);
        print(response.body);
        loginResponse loginResponseModel = loginResponse.fromJson(responseJson);
        print(loginResponseModel);
        if (loginResponseModel.success == 1) {
          await saveUserAuth(loginResponseModel);
          print("aaaaaaaa");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return DashBoardScreen();
          }));
          await Hive.box<int>(DatabaseHelper.authenticationDB).put("state", 1);
          print("bbbbbbb");
          print("Success doneeeeee");
          OurToast()
              .showSuccessToast("Welcome, ${loginResponseModel.userName}");
        } else {
          OurToast().showErrorToast("Invalid user credentials");
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      OurToast().showErrorToast(
        e.toString(),
      );
      print(e.toString());
    }
  }

  Future<void> signUp(Map<String, dynamic> toJson, BuildContext context) async {
    print("Inside signup");
    String url = "https://api.fmccart.com/client/signup";
    try {
      final response = await http.post(Uri.parse(url), body: (toJson));
      if (response.statusCode == 200) {
        print("Inside 200 code");
        String responseJson = json.decode(response.body);
        print(responseJson);
        if (responseJson.contains("Data Saved")) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const LoginScreen();
          }));
          OurToast().showSuccessToast("User signed in successfully");
        } else {
          OurToast().showErrorToast("Error Occured");
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      OurToast().showErrorToast(
        e.toString(),
      );
    }
  }

  Future<List<ProductModalClass>?> getProduct() async {
    // print("Inside getProduct");
    Hive.box<ProductModalClass>(DatabaseHelper.productdetailDB).clear();
    String url = "https://api.fmccart.com/client/products";
    List<ProductModalClass> productModalClass = [];
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print("Inside 200 code");
        var responseJson = json.decode(response.body);
        // print(responseJson);
        responseJson.forEach((e) {
          productModalClass.add(
            ProductModalClass.fromJson(e),
          );
          Hive.box<ProductModalClass>(DatabaseHelper.productdetailDB)
              .add(ProductModalClass.fromJson(e));
          // print(e);
        });
        // print(productModalClass);
        return productModalClass;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      OurToast().showErrorToast(
        e.toString(),
      );
      print(e);
    }
  }

  Future logout(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('token');
    Hive.box<int>(DatabaseHelper.authenticationDB).put("state", 0);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
    // Hive.box<loginResponse>(DatabaseHelper.userdetailDB).delete(1);
  }
}
