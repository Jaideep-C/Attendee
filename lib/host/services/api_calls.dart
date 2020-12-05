import 'dart:convert';

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
