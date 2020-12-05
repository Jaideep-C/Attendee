import 'dart:ui';

import 'package:flutter/material.dart';

import '../../models/session.dart';
import '../qr_scan/cam.dart';

class SessionView extends StatefulWidget {
  final Session session;
  SessionView({@required this.session});
  @override
  _SessionViewState createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  Session _session;
  @override
  void initState() {
    super.initState();
    this._session = widget.session;
  }

  void onScan(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Cam(
          sessionId: _session.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_session);
    return Scaffold(
      appBar: AppBar(
        title: Text(_session.name),
      ),
      body: Container(
        child: ListTile(
          title: Text(
            'Description',
            style: TextStyle(fontSize: 25),
          ),
          subtitle: Text(
            _session.description,
            // maxLines: 3,
          ),
          isThreeLine: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onScan(context),
        child: Icon(Icons.camera_enhance),
      ),
    );
  }
}
