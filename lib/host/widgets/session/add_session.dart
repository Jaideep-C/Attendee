import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../global/constants/const.dart';

class AddSessionTF extends StatefulWidget {
  @override
  _AddSessionTFState createState() => _AddSessionTFState();
}

class _AddSessionTFState extends State<AddSessionTF> {
  Map<String, dynamic> data = Map();
  String _err = '';

  bool _loading = false;
  Future<String> _callApi() async {
    var res = await http.post(
      Api.createSession,
      body: json.encode(data),
      headers: Api.header,
    );

    var body = json.decode(res.body);
    if (body.containsKey("err")) {
      return body["err"];
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    data['completed'] = false;

    void _submit() {
      print(data);
      try {
        setState(() {
          _loading = true;
        });

        _callApi().then((_) {
          setState(() {
            _err = _ ?? '';
            _loading = false;
          });
          if (_err == '') {
            print("POP");
            Navigator.pop(context);
          }
        });
      } on Exception catch (e) {
        print(e.toString() + ' BOT');
        setState(() {
          _err = e.toString();
          _loading = false;
        });
      }
    }

    Widget _btn() {
      return (!_loading)
          ? InkWell(
              onTap: _submit,
              child: Container(
                padding: EdgeInsets.all(14),
                child: Text("Create"),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
              ),
            )
          : CircularProgressIndicator();
    }

    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (_) => data['name'] = _,
              decoration: InputDecoration(
                labelText: 'name',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 2,
              onChanged: (_) => data['description'] = _,
              decoration: InputDecoration(labelText: "description"),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: (_err ?? '') != '',
              child: Text(
                _err,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            _btn(),
          ],
        ),
      ),
    );
  }
}
