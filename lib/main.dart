import 'package:flutter/material.dart';

import 'global/services/shared_pref.dart';

void main() {
  runApp(IsAuth());
}

class IsAuth extends StatefulWidget {
  @override
  _IsAuthState createState() => _IsAuthState();
}

class _IsAuthState extends State<IsAuth> {
  String _id;

  @override
  void initState() {
    Pref.getId(name: '_id').then((value) {
      setState(() {
        _id = value ?? '';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_id);
    return (_id == '')
        ? Container(
            color: Colors.cyan,
          )
        : Container(
            color: Colors.yellow,
          );
  }
}
