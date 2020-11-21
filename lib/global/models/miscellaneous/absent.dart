
import 'package:meta/meta.dart';

class Absent {
    Absent({
        @required this.count,
        @required this.sessions,
    });

    final int count;
    final List<String> sessions;

    factory Absent.fromJson(Map<String, dynamic> json) => Absent(
        count: json["count"],
        sessions: List<String>.from(json["sessions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "sessions": List<dynamic>.from(sessions.map((x) => x)),
    };
}