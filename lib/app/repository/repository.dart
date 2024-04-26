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

  Future<double> getValueKWh() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('ValueKWh') ?? 800.0;
  }

  Future<bool> saveValueKWh(double value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble('ValueKWh', value);
  }

  Future<bool> addRegistry(Registry reg) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonRecords = prefs.getStringList('records') ?? [];
    List<String> newList = [];
    newList.add(jsonEncode(reg.toJson()));
    newList.addAll(jsonRecords);
    return prefs.setStringList('records', newList);
  }

  Future<List<Registry>> getRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonRecords = prefs.getStringList('records') ?? [];
    return jsonRecords
        .map((jsonRegistry) => Registry.fromJson(jsonDecode(jsonRegistry)))
        .toList();
  }

  Future<bool> removeRegistry(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonRecords = prefs.getStringList('records') ?? [];
    jsonRecords.removeAt(index);
    return prefs.setStringList('records', jsonRecords);
  }
}