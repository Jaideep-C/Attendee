import 'dart:ui';
import 'package:attandee/global/constants/const.dart';
import 'package:attandee/global/models/token.dart';
import 'package:attandee/global/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> data = Map();
  String err = '';
  bool _loading = false;
  String sec = '';

  void onSubmit() {
    print(data);
    try {
      setState(() {
        _loading = true;
      });
      Authenticate.callApi(
        body: data,
        endPoint: Api.userSignIn,
      ).then(
        (value) {
          setState(() {
            _loading = false;
            err = value;
          });
          context.read<Token>().updateId();
        },
      );
    } on Exception catch (e) {
      print(e.toString() + ' BOT');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        actions: [
          FlatButton(
            child: Row(
              children: [
                Text('Login'),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.person),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueGrey,
                  Colors.white24,
                  Colors.white38,
                  Colors.white54,
                  Colors.white70,
                  Colors.white,
                  Colors.white70,
                  Colors.white54,
                  Colors.white38,
                  Colors.white24,
                  Colors.blueGrey,
                ],
              ),
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 300,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Enter Your Email ID',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (_) {
                            setState(() {
                              data['emailId'] = _;
                            });
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Enter a Password'),
                          obscureText: true,
                          onChanged: (_) {
                            setState(() {
                              data['password'] = _;
                            });
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          onChanged: (_) {
                            setState(() {
                              sec = _;
                            });
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          child: Text('SUBMIT'),
                          onPressed: () {},
                          color: Colors.amber[800],
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        Visibility(
                          visible: (err != ''),
                          child: Text(
                            err,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: sec == data['password'],
                          child: Text(
                            'The Pasword must be same !',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Consumer<Token>(
                          builder: (_, token, child) {
                            return child;
                          },
                          child: (_loading)
                              ? Center(child: CircularProgressIndicator())
                              : RaisedButton(
                                  child: Text('SUBMIT'),
                                  onPressed: onSubmit,
                                  color: Colors.amber[800],
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
