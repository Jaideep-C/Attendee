// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:attandee/global/models/absent.dart';
import 'package:attandee/global/models/attended.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

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

    factory User.fromJson(Map<String, dynamic> json) => User(
        attended: Attended.fromJson(json["attended"]),
        absent: Absent.fromJson(json["absent"]),
        isAdmin: json["isAdmin"],
        attendancePercentage: json["attendancePercentage"],
        id: json["_id"],
        batch: json["batch"],
        fullName: json["fullName"],
        uniqueId: json["uniqueId"],
        emailId: json["emailId"],
    );

    Map<String, dynamic> toJson() => {
        "attended": attended.toJson(),
        "absent": absent.toJson(),
        "isAdmin": isAdmin,
        "attendancePercentage": attendancePercentage,
        "_id": id,
        "batch": batch,
        "fullName": fullName,
        "uniqueId": uniqueId,
        "emailId": emailId,
    };
}



