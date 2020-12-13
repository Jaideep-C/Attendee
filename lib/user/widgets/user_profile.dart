import 'dart:convert';
import 'dart:ui';

import 'package:attandee/global/constants/const.dart';
import 'package:attandee/global/models/miscellaneous/absent.dart';
import 'package:attandee/global/models/miscellaneous/attended.dart';

import '../../global/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  final String id;

  const Profile({Key key, @required this.id}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _id;
  var _user;
  bool err = false;
  @override
  void initState() {
    super.initState();
    this._id = widget.id;
    _user = _getUser(this._id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return _profileWd(snapshot.data);
        }
        return CircularProgressIndicator(
          backgroundColor: Colors.red,
        );
      },
      future: _user,
    );
  }

  Future<User> _getUser(String _id) async {
    var res = await http.post(
      Api.getUser,
      body: json.encode({"_id": _id}),
      headers: Api.header,
    );
    var _body = json.decode(res.body);
    if (_body.containsKey("err")) {
      return User(
        attended: Attended(count: 0, sessions: []),
        absent: Absent(count: 0, sessions: []),
        isAdmin: false,
        attendancePercentage: 0,
        id: _id,
        batch: 'NAN',
        fullName: 'NaN',
        uniqueId: 'NaN',
        emailId: 'NaN',
      );
    }
    // print('HELP' + res.body);
    return userFromJson(res.body);
  }

  // Widget _profileWd(User user) {
  //   return Container(
  //     padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
  //     child: Column(
  //       // mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: _util("Name", user.fullName),
  //         ),
  //         SizedBox(height: 15),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: _util("Unique Id", user.uniqueId),
  //         ),
  //         SizedBox(height: 15),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: _util("Email Id", user.emailId),
  //         ),
  //         SizedBox(height: 15),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children:
  //               _util("Attendance", user.attendancePercentage.toString() + '%'),
  //         ),
  //         SizedBox(height: 15),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children:
  //               _util("Attended Sessions", user.attended.count.toString()),
  //         ),
  //         SizedBox(height: 15),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: _util("Absent Sessions", user.absent.count.toString()),
  //         ),
  //         SizedBox(height: 15),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: _util(
  //             "Total Sessions",
  //             (user.absent.count + user.attended.count).toString(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // List<Widget> _util(String first, String second) {
  //   return [
  //     Text(
  //       first,
  //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  //     ),
  //     Text(
  //       second,
  //       style: TextStyle(fontSize: 20),
  //     ),
  //   ];
  // }
  Widget _profileWd(User user) {
    TableRow _oneRow({String key, String value}) {
      return TableRow(children: [
        Text(
          key,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        Text(value, style: TextStyle(fontSize: 25))
      ]);
    }

    return Container(
      padding: EdgeInsets.all(20),
      child: Table(
        children: [
          _oneRow(key: "Name", value: user.fullName),
          _oneRow(key: "Unique id", value: user.uniqueId),
          _oneRow(key: "Email id", value: user.emailId),
          _oneRow(
            key: "Attendance",
            value: user.attendancePercentage.toString() + '%',
          ),
          _oneRow(
              key: "Total Sessions",
              value: (user.absent.count + user.attended.count).toString()),
        ],
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
