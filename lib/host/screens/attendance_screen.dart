import 'package:flutter/material.dart';

import '../widgets/draw.dart';
import '../widgets/qr_scan/QrScan.dart';

class TakeAttendance extends StatefulWidget {
  @override
  _TakeAttendanceState createState() => _TakeAttendanceState();
}

class _TakeAttendanceState extends State<TakeAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(),
      body: Container(
        child: QrScan(),
      ),
    );
  }
}
