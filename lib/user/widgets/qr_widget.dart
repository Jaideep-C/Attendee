import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../global/services/shared_pref.dart';

class QrWidget extends StatefulWidget {
  @override
  _QrWidgetState createState() => _QrWidgetState();
}

class _QrWidgetState extends State<QrWidget> {
  String _id = '';
  bool _loading = true;
  @override
  void initState() {
    setState(() => _loading = true);
    Pref.getId(name: '_id').then((value) {
      setState(() {
        _id = value;
        _loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var time = 10;
    Widget _qr() {
      return TimerBuilder.periodic(
        Duration(
          seconds: time,
        ),
        builder: (_) {
          var _t = time + 1;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimerBuilder.periodic(Duration(seconds: 1), builder: (_) {
                _t--;
                return Text(
                  'Expires in $_t',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              QrImage(
                data: _id + '  ' + DateTime.now().toString(),
                version: QrVersions.auto,
                size: MediaQuery.of(context).size.width * 0.8,
              ),
            ],
          );
        },
      );
    }

    Widget _body() {
      if (_id == '') {
        return Icon(
          Icons.error,
          size: MediaQuery.of(context).size.width * 0.8,
          color: Colors.red,
        );
      }
      return (_loading) ? CircularProgressIndicator() : _qr();
    }

    return Container(
      color: Colors.white,
      child: Center(
        child: _body(),
      ),
    );
  }
}
