import 'package:flutter/material.dart';

import '../screens/session_screen.dart';

// import '../screens/attendance_screen.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 50,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.orange, fontSize: 25),
            ),
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Session'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SessionPage(),
                ),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail_sharp),
            title: Text('User Attendance'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          // ListTile(
          //   leading: Icon(Icons.check),
          //   title: Text('Attendance'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => TakeAttendance()),
          //     );
          //     // Navigator.of(context).pop();
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.power_settings_new),
          //   title: Text('Log Out'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          // ListTile(
          //   leading: Icon(Icons.exit_to_app),
          //   title: Text('Logout'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
        ],
      ),
    );
  }
}
