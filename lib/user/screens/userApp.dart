import 'package:attandee/user/screens/absent.dart';
import 'package:attandee/user/screens/attended.dart';
import 'package:attandee/user/screens/qr_screen.dart';
import 'package:attandee/user/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global/models/token.dart';
import '../../global/services/shared_pref.dart';

class UserApp extends StatefulWidget {
  @override
  _UserAppState createState() => _UserAppState();
}

class _UserAppState extends State<UserApp> {
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
          body: Body(),
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var id;

  @override
  void initState() {
    super.initState();
    this.id = Pref.getId(name: "_id");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: id,
      builder: (_, snapshot) {
        if (snapshot.hasData == false) {
          return Center(child: CircularProgressIndicator());
        }
        var _id = snapshot.data;
        return Column(
          children: [
            Center(
              child: Profile(id: _id),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendedScreen(id: _id),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.7),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: Text("Attended"),
                    padding: EdgeInsets.all(15),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QrPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyan.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.cyan,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Text('QrCode'),
                    padding: EdgeInsets.all(15),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AbsentScreen(id: _id),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: Text("Absent"),
                    padding: EdgeInsets.all(15),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
