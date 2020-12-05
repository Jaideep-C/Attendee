import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/const.dart';
import 'shared_pref.dart';

class Authenticate {
  static Future<String> callApi({
    Map<String, String> body,
    String endPoint,
  }) async {
    try {
      print(json.encode(body));
      var _body = json.encode(body);
      var res = await http.post(
        endPoint,
        body: _body,
        headers: Api.header,
      );
      Map<String, dynamic> resBody = json.decode(res.body);

      if (res.statusCode == 200) {
        String _id = resBody['_id'] ?? '';
        Pref.saveId(name: '_id', value: _id);
        if (_id == '' || resBody['err'] != null) {
          return resBody['err'];
        } else {
          return '';
        }
      } else {
        print("LOL " + resBody.toString());
        return resBody['err'] ?? 'Try Again';
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }

  static Future<bool> isHost() async {
    String _id = await Pref.getId(name: '_id');
    var _reqBody = {"_id": (_id ?? '')};

    var hostRes = await http.post(
      Api.getHost,
      body: json.encode(_reqBody),
      headers: Api.header,
    );
    Map<String, dynamic> hostResBody = json.decode(hostRes.body);
    print("HOST== " + hostResBody.toString());
    if (hostResBody['err'] == null || hostResBody['isHost'] == true) {
      return true;
    }
    var userRes = await http.post(
      Api.getUser,
      body: json.encode(_reqBody),
      headers: Api.header,
    );
    Map<String, dynamic> userResBody = json.decode(userRes.body);
    print("USER== " + userResBody.toString());
    if (userResBody['err'] == null || userResBody['isAdmin'] == false) {
      return false;
    }
    return false;
  }
}
