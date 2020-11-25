import 'package:attandee/global/services/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timer_builder/timer_builder.dart';

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
    Widget _qr() {
      return TimerBuilder.periodic(
        Duration(
          seconds: 10,
        ),
        builder: (_) {
          return QrImage(
            data: _id + '  ' + DateTime.now().toString(),
            version: QrVersions.auto,
            size: MediaQuery.of(context).size.width * 0.8,
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
