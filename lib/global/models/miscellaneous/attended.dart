import 'package:meta/meta.dart';

class Attended {
    Attended({
        @required this.count,
        @required this.sessions,
    });

    final int count;
    final List<String> sessions;

    factory Attended.fromJson(Map<String, dynamic> json) => Attended(
        count: json["count"],
        sessions: List<String>.from(json["sessions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "sessions": List<dynamic>.from(sessions.map((x) => x)),
    };
}