import 'package:flutter/material.dart';

import '../widgets/sign_out.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  String _txt;
  HomePage(this._txt);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("HomePage"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'HomePage Id ${widget._txt}',
              ),
              SizedBox(
                height: 10,
              ),
              SignOut(),
            ],
          ),
        ),
      ),
    );
  }
}
