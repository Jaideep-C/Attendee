import 'dart:convert';
import 'package:attandee/global/constants/const.dart';
import 'package:attandee/global/services/shared_pref.dart';
import 'package:http/http.dart' as http;

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
}
