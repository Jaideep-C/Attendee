import 'package:attandee/global/services/shared_pref.dart';
import 'package:flutter/material.dart';
import '../widgets/user_profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _id;
  @override
  void initState() {
    super.initState();
    _id = Pref.getId(name: "_id");
    print(_id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _id,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return Profile(id: snapshot.data);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
