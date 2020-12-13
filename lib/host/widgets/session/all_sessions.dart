import 'dart:ui';

import 'session_view.dart';
import '../../services/api_calls.dart';
import '../../models/session.dart';
import 'package:flutter/material.dart';

class AllSessions extends StatefulWidget {
  @override
  _AllSessionsState createState() => _AllSessionsState();
}

class _AllSessionsState extends State<AllSessions> {
  var _sessions;

  @override
  void initState() {
    super.initState();
    _sessions = allSessionList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Session>>(
        future: _sessions,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var name = snapshot.data[index].name;
                var completed = (snapshot.data[index].completed);
                var _session = (snapshot.data[index]);
                return ListTile(
                  leading: Icon(Icons.book_sharp),
                  title: Text(name),
                  subtitle: Text(
                    (completed ?? false) ? "Inactive" : "Active",
                    style: TextStyle(
                      color: (completed ? Colors.red : Colors.green),
                    ),
                  ),
                  onTap: () {
                    // print("Yeah");
                    if (!completed) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SessionView(session: _session),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
