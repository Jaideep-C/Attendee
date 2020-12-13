import 'dart:ui';

import 'package:attandee/host/services/api_calls.dart';
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
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    this._session = widget.session;
    print(this._session.attendees);
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'Description',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  _session.description,
                  style: TextStyle(fontSize: 20),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 40),
              ],
            ),
            (_loading)
                ? CircularProgressIndicator()
                : InkWell(
                    onTap: () {
                      setState(() {
                        _loading = true;
                      });
                      markComplete(_session.id).then((_) {
                        setState(() {
                          _loading = false;
                        });
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        'Mark as completed',
                        style: TextStyle(color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                    ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onScan(context),
        child: Icon(Icons.camera_enhance),
      ),
    );
  }
}
