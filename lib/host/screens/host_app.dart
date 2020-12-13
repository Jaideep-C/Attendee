import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global/models/token.dart';
import '../../global/services/shared_pref.dart';
import '../widgets/draw.dart';

class HostApp extends StatefulWidget {
  @override
  _HostAppState createState() => _HostAppState();
}

class _HostAppState extends State<HostApp> {
  @override
  Widget build(BuildContext context) {
    void _signOut() {
      Pref.saveId(name: '_id', value: '').then((value) {
        context.read<Token>().updateId();
      });
    }

    return Consumer<Token>(
      builder: (_, val, child) => child,
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Side menu'),
          actions: [
            FlatButton(
              child: Row(
                children: [
                  Icon(Icons.power_settings_new),
                  SizedBox(width: 1),
                  Text('Sign Out'),
                ],
              ),
              onPressed: () {
                _signOut();
              },
            ),
          ],
        ),
        body: Container(
          child: Center(
            child: Text('Welcome Host😁\nHave a\nGood D🍪y',
                style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
