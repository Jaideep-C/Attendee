import 'package:attandee/global/services/shared_pref.dart';
import 'package:flutter/cupertino.dart';

class Token extends ChangeNotifier {
  String _id;
  String get id => _id;

  Token() {
    Pref.getId(name: '_id').then((value) => this._id = '');
  }

  void updateId() {
    Pref.getId(name: '_id').then((value) => this._id = '');
    notifyListeners();
  }
}
