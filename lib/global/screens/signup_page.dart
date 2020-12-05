import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/const.dart';
import '../services/auth.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signUp';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> data = Map();
  String err = '';
  bool _loading = false;
  String sec = '';

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      print(data);
      if (sec != data['password']) {
        setState(() {
          err = 'Passwords do not match';
        });
        return;
      } else {
        setState(() {
          err = '';
        });
      }
      try {
        setState(() {
          _loading = true;
        });
        Authenticate.callApi(
          body: data,
          endPoint: Api.userSignUp,
        ).then(
          (value) {
            setState(() {
              _loading = false;
              err = value;
            });
            if (err == '') {
              Navigator.pop(context);
            }
            // context.read<Token>().updateId();
          },
        );
      } on Exception catch (e) {
        print(e.toString() + ' BOT');
      }
    }

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
            child: Container(
              // height: 300,
              width: MediaQuery.of(context).size.width * 0.9,
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
                          labelText: 'Enter Your Full Name',
                        ),
                        onChanged: (_) {
                          setState(() {
                            data['fullName'] = _;
                          });
                        },
                      ),
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
                        decoration: InputDecoration(
                          labelText: 'Enter Your UniqueId',
                        ),
                        onChanged: (_) {
                          setState(() {
                            data['uniqueId'] = _;
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
                      Visibility(
                        visible: (err != ''),
                        child: Text(
                          err,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      (_loading)
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
                    ],
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
