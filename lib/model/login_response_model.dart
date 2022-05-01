import 'package:hive_flutter/hive_flutter.dart';
part 'login_response_model.g.dart';
@HiveType(typeId: 0)
class loginResponse extends HiveObject {
  @HiveField(0)

  dynamic status;
  @HiveField(1)

  String? token;
  @HiveField(2)

  int? success;
  @HiveField(3)

  String? userName;
  @HiveField(4)

  int? userId;

  loginResponse(
      {this.status, this.token, this.success, this.userName, this.userId});

  loginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    success = json['success'];
    userName = json['user_name'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    data['success'] = this.success;
    data['user_name'] = this.userName;
    data['user_id'] = this.userId;
    return data;
  }
}