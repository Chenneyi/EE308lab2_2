import 'package:flutter/material.dart';

class userData with ChangeNotifier {
  String userid = "NULL";
  String username = "player";

  String get getuserid => userid;

  updateuserid(String id) {
    this.userid = id;
    notifyListeners();
  }

  updateusername(String name) {
    this.username = name;
    notifyListeners();
  }
}
