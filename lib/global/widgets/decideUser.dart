import 'package:attandee/global/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:attandee/user/screens/userApp.dart';

class Decide extends StatefulWidget {
  @override
  _DecideState createState() => _DecideState();
}

class _DecideState extends State<Decide> {
  bool _isHost;
  bool _loading;
  @override
  void initState() {
    print("YEAH");
    setState(() {
      _loading = true;
    });
    Authenticate.isHost().then((value) {
      setState(() {
        _isHost = value;
        _loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading ?? true) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return (_isHost)
        ? Container(
            child: Center(
              child: Text("isHost $_isHost"),
            ),
          )
        : UserApp();
  }
}
