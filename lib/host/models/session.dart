// To parse this JSON data, do
//
//     final session = sessionFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Session> sessionFromJson(String str) =>
    List<Session>.from(json.decode(str).map((x) => Session.fromJson(x)));

String sessionToJson(List<Session> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Session {
  Session({
    @required this.attendees,
    @required this.description,
    @required this.id,
    @required this.completed,
    @required this.name,
  });

  final List<dynamic> attendees;
  final String description;
  final String id;
  final bool completed;
  final String name;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        attendees: List<dynamic>.from(json["attendees"].map((x) => x)),
        description: json["description"],
        id: json["_id"],
        completed: json["completed"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "attendees": List<dynamic>.from(attendees.map((x) => x)),
        "description": description,
        "_id": id,
        "completed": completed,
        "name": name,
      };
}
