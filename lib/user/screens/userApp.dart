import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global/models/token.dart';
import '../../global/services/shared_pref.dart';
import '../widgets/qr_widget.dart';
import 'user_home.dart';

class UserApp extends StatefulWidget {
  @override
  _UserAppState createState() => _UserAppState();
}

class _UserAppState extends State<UserApp> {
  bool _isQr = false;
  @override
  Widget build(BuildContext context) {
    void _signOut() {
      Pref.saveId(name: '_id', value: '').then((value) {
        context.read<Token>().updateId();
      });
    }

    return MaterialApp(
      home: Consumer<Token>(
        builder: (_, val, child) => child,
        child: Scaffold(
          appBar: AppBar(
            title: Text('User'),
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
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              !_isQr
                  ? Container(
                      child: Center(
                        child: HomeScreen(),
                      ),
                    )
                  : QrWidget(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              InkWell(
                onTap: () => setState(() => _isQr = !_isQr),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: Text('QrCode'),
                  padding: EdgeInsets.all(15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
