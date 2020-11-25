import 'package:attandee/global/services/shared_pref.dart';
import 'package:flutter/cupertino.dart';

class Token extends ChangeNotifier {
  String _id;
  String get id => _id;

  Token() {
    this._id = '';
    this.updateId();
  }

  Future<void> updateId() async {
    this._id = await Pref.getId(name: '_id');
    notifyListeners();
  }
}
