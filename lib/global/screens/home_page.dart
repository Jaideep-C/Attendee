import 'package:attandee/global/widgets/sign_out.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
                'HomePage',
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
