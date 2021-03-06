import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/db/db_helper.dart';
import 'package:myapp/screen/authentication_screen/login_screen.dart';
import 'package:myapp/screen/dashboard_screens/dashboard_screen.dart';

class OuterLayerScreen extends StatefulWidget {
  const OuterLayerScreen({Key? key}) : super(key: key);

  @override
  _OuterLayerScreenState createState() => _OuterLayerScreenState();
}

class _OuterLayerScreenState extends State<OuterLayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable:
          Hive.box<int>(DatabaseHelper.authenticationDB).listenable(),
      builder: (context, Box<int> boxs, child) {
        int value = boxs.get("state", defaultValue: 0)!;
        return value == 0 ? const LoginScreen() : const DashBoardScreen();
      },
    ));
  }
}
