import 'package:book_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var client = http.Client();

  final prefs = await _initPrefs();

  runApp(BookApp(client: client, prefs: prefs));
}

Future<SharedPreferences> _initPrefs() async {
  return await SharedPreferences.getInstance();
}
