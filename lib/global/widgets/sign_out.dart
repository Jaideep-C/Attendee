import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/token.dart';
import '../services/shared_pref.dart';

class SignOut extends StatefulWidget {
  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  @override
  Widget build(BuildContext context) {
    void _signOut() {
      Pref.saveId(name: '_id', value: '').then((value) {
        context.read<Token>().updateId();
      });
    }

    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.3,
      color: Colors.amber,
      child: Consumer<Token>(
        builder: (_, val, child) => child,
        child: InkWell(
          onTap: _signOut,
          child: Center(
            child: Text("SignOut"),
          ),
        ),
      ),
    );
  }
}
