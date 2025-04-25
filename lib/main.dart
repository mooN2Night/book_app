import 'package:book_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  var client = http.Client();

  runApp(BookApp(client: client));
}
