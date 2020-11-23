import 'dart:ui';

import 'package:attandee/global/constants/const.dart';
import 'package:attandee/global/models/token.dart';
import 'package:attandee/global/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginInputFields extends StatefulWidget {
  @override
  _LoginInputFieldsState createState() => _LoginInputFieldsState();
}

class _LoginInputFieldsState extends State<LoginInputFields> {
  Map<String, String> data = Map();
  String err = '';
  @override
  Widget build(BuildContext context) {
    Widget inpField({String param}) {
      return Container(
        padding: EdgeInsets.all(10),
        child: TextField(
          onChanged: (_) {
            setState(() {
              data[param] = _;
            });
          },
          decoration: InputDecoration(labelText: param),
        ),
      );
    }

    void onSubmit() {
      print(data);
      try {
        Authenticate.callApi(
          body: data,
          endPoint: Api.userSignIn,
        ).then(
          (value) {
            setState(() {
              err = value;
            });
            context.read<Token>().updateId();
          },
        );
      } on Exception catch (e) {
        print(e.toString() + ' BOT');
      }
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          inpField(param: 'emailId'),
          inpField(param: 'password'),
          Visibility(
            visible: (err != ''),
            child: Text(
              err,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          Consumer<Token>(
            builder: (_, token, child) {
              return child;
            },
            child: FloatingActionButton(
              onPressed: onSubmit,
              child: Text("Submit"),
            ),
          )
        ],
      ),
    );
  }
}
