import 'package:flutter/material.dart';

import '../widgets/draw.dart';
import '../widgets/session/add_session.dart';
import '../widgets/session/all_sessions.dart';

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  bool refresh = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Session's"),
      ),
      body: Container(
        child: (refresh) ? Container(child: AllSessions()) : AllSessions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSession()),
          ).then((value) {
            setState(() {
              refresh = !refresh;
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Session"),
      ),
      body: Container(
        child: AddSessionTF(),
      ),
    );
  }
}
