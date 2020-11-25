import 'package:flutter/material.dart';
import '../widgets/qr_widget.dart';

class UserApp extends StatefulWidget {
  @override
  _UserAppState createState() => _UserAppState();
}

class _UserAppState extends State<UserApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: QrWidget(),
          ),
        ),
      ),
    );
  }
}
