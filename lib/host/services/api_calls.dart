import 'dart:convert';

import 'package:attandee/global/models/miscellaneous/absent.dart';
import 'package:attandee/global/models/miscellaneous/attended.dart';
import 'package:attandee/global/models/user.dart';
import 'package:http/http.dart' as http;

import '../../global/constants/const.dart';
import '../models/session.dart';

Future<List<Session>> allSessionList() async {
  var res = await http.get(
    Api.getAllSessions,
    headers: Api.header,
  );
  dynamic resBody = json.decode(res.body);
  try {
    if (res.statusCode != 200 || (resBody['err'] != null)) {
      return [
        Session(
          attendees: [''],
          completed: true,
          id: '',
          name: 'Server Problem',
          description: '',
        ),
      ];
    }
  } on Exception catch (e) {
    print(e);
  } finally {
    print('HEY' + sessionFromJson(res.body.toString()).toString());
    // ignore: control_flow_in_finally
    return sessionFromJson(res.body);
  }
}

Future<List<User>> allUserList() async {
  var res = await http.get(
    Api.getAllUsers,
    headers: Api.header,
  );
  dynamic resBody = json.decode(res.body);
  try {
    if (res.statusCode != 200 || (resBody['err'] != null)) {
      return [
        User(
          attended: Attended(count: 0, sessions: []),
          absent: Absent(count: 0, sessions: []),
          isAdmin: false,
          attendancePercentage: 0,
          id: '_id',
          batch: 'NAN',
          fullName: 'NaN',
          uniqueId: 'NaN',
          emailId: 'NaN',
        ),
      ];
    }
  } on Exception catch (e) {
    print(e);
  } finally {
    // ignore: control_flow_in_finally
    return userListFromJson(res.body);
  }
}

Future<void> markComplete(String _id) async {
  var res = await http.post(
    Api.completeSession,
    body: json.encode({"_id": _id}),
    headers: Api.header,
  );
  var body = json.decode(res.body);
  if (body.containsKey("err")) {
    return;
  }
  return;
}
