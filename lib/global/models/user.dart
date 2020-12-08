// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:attandee/global/models/miscellaneous/absent.dart';
import 'package:meta/meta.dart';

import 'miscellaneous/attended.dart';

List<User> userListFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    @required this.attended,
    @required this.absent,
    @required this.isAdmin,
    @required this.attendancePercentage,
    @required this.id,
    @required this.batch,
    @required this.fullName,
    @required this.uniqueId,
    @required this.emailId,
  });

  final Attended attended;
  final Absent absent;
  final bool isAdmin;
  final int attendancePercentage;
  final String id;
  final String batch;
  final String fullName;
  final String uniqueId;
  final String emailId;

  factory User.fromJson(Map<String, dynamic> json) {
    print(json["attendancePercentage"]);
    return User(
      attended: Attended.fromJson(json["attended"]),
      absent: Absent.fromJson(json["absent"]),
      isAdmin: json["isAdmin"],
      attendancePercentage: json["attendancePercentage"].toInt(),
      id: json["_id"],
      batch: json["batch"],
      fullName: json["fullName"],
      uniqueId: json["uniqueId"],
      emailId: json["emailId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "attended": attended.toJson(),
        "absent": absent.toJson(),
        "isAdmin": isAdmin,
        "attendancePercentage": attendancePercentage + 0.0,
        "_id": id,
        "batch": batch,
        "fullName": fullName,
        "uniqueId": uniqueId,
        "emailId": emailId,
      };
}
