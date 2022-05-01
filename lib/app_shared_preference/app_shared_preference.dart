
// import 'package:shared_preferences/shared_preferences.dart';

// class AppSharedPreference {
//   done() async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     await _prefs.setInt("done", 0);
//   }

//   Future<bool> saveUserAuth(LoginResponseModel loginResponseModel) async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     await _prefs.setString("token", loginResponseModel.token ?? "");
//     return true;
//   }

//   Future<bool> saveUsernameAndemail(UserModel userModel) async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();

//     await _prefs.setString("user_name", userModel.empname ?? "");
//     await _prefs.setString("email", userModel.email ?? "");
//     await _prefs.setString("company", userModel.company ?? "");
//     return true;
//   }

//   Future logout() async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     _prefs.remove('token');
//     _prefs.remove('user_name');
//     _prefs.remove("email");
//     _prefs.remove("company");
//   }

//   Future<String> getToken() async {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     String _userData = _prefs.getString("token").toString();

//     return _userData;
//   }
// }
