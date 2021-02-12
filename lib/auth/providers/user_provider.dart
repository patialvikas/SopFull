import 'package:flutter/foundation.dart';
import '../../models/UserModel.dart';
import '../../models/UserModel.dart';
import '../../models/UserModel.dart';

class UserProvider with ChangeNotifier {
  Data _user = new Data();

  Data get user => _user;

  void setUser(Data user) {
    _user = user;
    notifyListeners();
  }
}