// To parse this JSON data, do
//
//     final host = hostFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

Host hostFromJson(String str) => Host.fromJson(json.decode(str));

String hostToJson(Host data) => json.encode(data.toJson());

class Host {
  Host({
    @required this.isAdmin,
    @required this.id,
    @required this.fullName,
    @required this.emailId,
  });

  final bool isAdmin;
  final String id;
  final String fullName;
  final String emailId;

  factory Host.fromJson(Map<String, dynamic> json) => Host(
        isAdmin: json["isAdmin"],
        id: json["_id"],
        fullName: json["fullName"],
        emailId: json["emailId"],
      );

  Map<String, dynamic> toJson() => {
        "isAdmin": isAdmin,
        "_id": id,
        "fullName": fullName,
        "emailId": emailId,
      };
}
