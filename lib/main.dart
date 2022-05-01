import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/db/db_helper.dart';
import 'package:myapp/model/login_response_model.dart';
import 'package:myapp/model/product_model.dart';
import 'package:myapp/screen/splash_screen/splash_screen.dart';
import 'services/app_bindings/mybindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(loginResponseAdapter());
  Hive.registerAdapter(ProductModalClassAdapter());
  await Hive.openBox<int>(DatabaseHelper.authenticationDB);
  await Hive.openBox<loginResponse>(DatabaseHelper.userdetailDB);
  await Hive.openBox<ProductModalClass>(DatabaseHelper.productdetailDB);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => GetMaterialApp(
        title: "Fmc Cart",
        initialBinding: MyBinding(),
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!);
        },
        home: const SplashScreen(),
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
      ),
    );
  }
}
