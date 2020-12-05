import 'package:flutter/material.dart';

import 'cam.dart';

class QrScan extends StatefulWidget {
  @override
  _QrScanState createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cam(
                  sessionId: "lol",
                ),
              ),
            );
          },
          child: Container(
            color: Colors.orange,
            padding: EdgeInsets.all(20),
            child: Text(
              "Scan",
              style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
