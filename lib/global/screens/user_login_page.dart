import 'dart:ui';
import 'package:attandee/global/constants/const.dart';
import 'package:attandee/global/models/token.dart';
import 'package:attandee/global/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> data = Map();
  String err = '';
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          FlatButton(
            child: Row(
              children: [
                Text('Sign Up'),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.person_add),
              ],
            ),
            onPressed: () {
              // Push to sign up screen HERE
            },
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
                height: 260,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                          onChanged: (_) {
                            setState(() {
                              data['emailId'] = _;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty || value.length <= 5) {
                              return 'Invalid Password';
                            }
                            return null;
                          },
                          onChanged: (_) {
                            setState(() {
                              data['password'] = _;
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
