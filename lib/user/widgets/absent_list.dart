import 'package:attandee/global/models/miscellaneous/attended.dart';
import 'package:attandee/host/models/session.dart';
import 'package:attandee/host/services/api_calls.dart';
import 'package:flutter/material.dart';

class AbsentListView extends StatefulWidget {
  final Attended attended;
  const AbsentListView({Key key, @required this.attended}) : super(key: key);
  @override
  _AbsentListViewState createState() => _AbsentListViewState();
}

class _AbsentListViewState extends State<AbsentListView> {
  var _sessions;
  Attended _attended;

  @override
  void initState() {
    super.initState();
    this._sessions = allSessionList();
    this._attended = widget.attended;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Session>>(
        future: _sessions,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            var _newList = _filterIt(snapshot.data);

            return ListView.builder(
              itemCount: _newList.length,
              itemBuilder: (BuildContext context, int index) {
                var name = _newList[index].name;
                var _description = (_newList[index].description);
                return ListTile(
                  leading: Icon(Icons.book_sharp, color: Colors.red),
                  title: Text(name),
                  subtitle: Text(_description),
                );
              },
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  List<Session> _filterIt(List<Session> data) {
    List<Session> _new = [];
    for (int i = 0; i < data.length; i++) {
      if (!_attended.sessions.contains(data[i].id)) {
        _new.add(data[i]);
      }
    }
    return _new;
  }
}
