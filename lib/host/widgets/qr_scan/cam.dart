import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../global/constants/const.dart';

String _trim(String _result) {
  String ans = '';
  for (int i = 0; i + 2 < _result.length; i++) {
    ans += _result[i];

    if (_result[i + 1] + _result[i + 2] == '  ') {
      break;
    }
  }
  print(ans + 'RESULT');
  return ans;
}

class Cam extends StatefulWidget {
  final String sessionId;
  Cam({
    Key key,
    @required this.sessionId,
  }) : super(key: key);
  @override
  _CamState createState() => _CamState();
}

class _CamState extends State<Cam> {
  bool _isLoading = false;
  String _res = '';
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    void _controller(QRViewController controller) {
      this.controller = controller;
      controller.scannedDataStream.listen(
        (String scanData) {
          String _result = scanData ?? '';
          if (_result != '') {
            setState(() {
              _isLoading = true;
            });
            controller.pauseCamera();
            // API Call
            _apiCall(userId: _trim(_result)).then((_) {
              setState(() {
                if (_) {
                  _res = '1'; //200 Ok
                } else {
                  _res = '0'; //Fail
                }
              });
              _wait().then((_) {
                setState(() {
                  _res = '';
                  _isLoading = false;
                });

                controller.resumeCamera();
              });
            });
          }
        },
      );
    }

    Widget _loading() {
      return Center(
        child: Visibility(
          visible: (_isLoading),
          child: (_res == '')
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Please Wait!",
                      style: new TextStyle(
                        fontSize: 30.0,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircularProgressIndicator(),
                  ],
                )
              : Container(
                  child: (_res == '1')
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                              size: MediaQuery.of(context).size.width * 0.8,
                            ),
                            Text(
                              "Done!",
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red,
                              size: MediaQuery.of(context).size.width * 0.8,
                            ),
                            Text(
                              "Try Again!",
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
        ),
      );
    }

    Widget _qrCam() {
      return QRView(
        key: qrKey,
        onQRViewCreated: _controller,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.teal,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          _qrCam(),
          _loading(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> _apiCall({String userId}) async {
    await Future.delayed(Duration(seconds: 3));

    var res = await http.post(
      Api.api + '/session/addAttendee',
      body: json.encode({"userId": userId, "sessionId": widget.sessionId}),
      headers: Api.header,
    );
    var body = json.decode(res.body);
    if (body.containsKey("err")) {
      return false;
    }
    return true;
  }

  Future<void> _wait() async {
    await Future.delayed(Duration(seconds: 3));
  }
}
