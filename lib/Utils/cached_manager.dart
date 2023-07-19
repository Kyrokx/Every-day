import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachedManager {
  /*String? uid;

  CachedManager({this.uid});*/

  Future writeCachedData(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future readCachedData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString(key);
    return value;
  }

  Future removeCachedData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

}