import 'dart:convert';
import 'package:attandee/global/services/shared_pref.dart';
import 'package:http/http.dart' as http;

class Authenticate {
  static Future<String> callApi({
    Map<String, String> body,
    String endPoint,
  }) async {
    var res = await http.post(endPoint, body: json.encode(body));
    try {
      if (res.statusCode == 200) {
        Map<String, String> body = json.decode(res.body);
        String _id = body['_id'] ?? '';
        Pref.saveId(name: '_id', value: _id);
        if (_id == '' || body['err'] != null) {
          return body['err'];
        } else {
          return '';
        }
      } else {
        return 'Try Again';
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }

  //   static Future<String> userSignIn(Map<String, String> body) async {
  //   var res = await http.post(Api.userSignIn, body: json.encode(body));
  //   try {
  //     if (res.statusCode == 200) {
  //       Map<String, String> body = json.decode(res.body);
  //       String _id = body['_id'] ?? '';
  //       Pref.saveId(name: '_id', value: _id);
  //       if (_id == '' || body['err'] != null) {
  //         return body['err'];
  //       } else {
  //         return '';
  //       }
  //     } else {
  //       return 'Try Again';
  //     }
  //   } on Exception catch (e) {
  //     return e.toString();
  //   }
  // }

  // static Future<String> userSignUp(Map<String, String> body) async {
  //   var res = await http.post(Api.userSignUp, body: json.encode(body));
  //   try {
  //     if (res.statusCode == 200) {
  //       Map<String, String> body = json.decode(res.body);
  //       String _id = body['_id'] ?? '';
  //       Pref.saveId(name: '_id', value: _id);
  //       if (_id == '' || body['err'] != null) {
  //         return body['err'];
  //       } else {
  //         return '';
  //       }
  //     } else {
  //       return 'Try Again';
  //     }
  //   } on Exception catch (e) {
  //     return e.toString();
  //   }
  // }

  // static Future<String> hostSignIn(Map<String, String> body) async {
  //   var res = await http.post(Api.hostSignIn, body: json.encode(body));
  //   try {
  //     if (res.statusCode == 200) {
  //       Map<String, String> body = json.decode(res.body);
  //       String _id = body['_id'] ?? '';
  //       Pref.saveId(name: '_id', value: _id);
  //       if (_id == '' || body['err'] != null) {
  //         return body['err'];
  //       } else {
  //         return '';
  //       }
  //     } else {
  //       return 'Try Again';
  //     }
  //   } on Exception catch (e) {
  //     return e.toString();
  //   }
  // }

}
