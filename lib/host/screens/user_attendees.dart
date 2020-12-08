import 'package:attandee/global/models/user.dart';
import 'package:attandee/host/services/api_calls.dart';
import 'package:attandee/user/screens/absent.dart';
import 'package:attandee/user/screens/attended.dart';
import 'package:attandee/user/screens/qr_screen.dart';
import 'package:attandee/user/widgets/user_profile.dart';
import 'package:flutter/material.dart';

class UserAttendance extends StatefulWidget {
  @override
  _UserAttendanceState createState() => _UserAttendanceState();
}

class _UserAttendanceState extends State<UserAttendance> {
  var users;
  @override
  void initState() {
    super.initState();
    this.users = allUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User's"),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder<List<User>>(
            future: users,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return AllUsersView(users: snapshot.data);
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class AllUsersView extends StatefulWidget {
  final List<User> users;

  const AllUsersView({Key key, @required this.users}) : super(key: key);
  @override
  AllUsersViewState createState() => AllUsersViewState();
}

class AllUsersViewState extends State<AllUsersView> {
  List<User> _users;
  @override
  void initState() {
    super.initState();
    this._users = widget.users;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (BuildContext context, int index) {
          User _user = _users[index];
          return ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.cyan,
            ),
            title: Text(_user.fullName),
            subtitle: Text(_user.emailId),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OneUser(user: _user),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class OneUser extends StatefulWidget {
  final User user;

  const OneUser({Key key, @required this.user}) : super(key: key);
  @override
  _OneUserState createState() => _OneUserState();
}

class _OneUserState extends State<OneUser> {
  User _user;
  @override
  void initState() {
    super.initState();
    this._user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    String _id = _user.id;
    return Scaffold(
      appBar: AppBar(
        title: Text(_user.fullName),
      ),
      body: Column(
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
      ),
    );
  }
}
