import 'dart:convert';

import 'package:kwcalculator/app/models/registry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Future<bool> saveShowHelpToStart(bool showHelp) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool('ShowHelp', showHelp);
  }

  Future<bool> getShowHelpToStart() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ShowHelp') ?? true;
  }
}