import 'package:book_app/core/app/app_initializer.dart';
import 'package:book_app/core/theme/theme.dart';
import 'package:book_app/feature/search/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookApp extends StatelessWidget {
  const BookApp({super.key, required this.client, required this.prefs});

  final Client client;
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return AppInitializer(
      client: client,
      prefs: prefs,
      child: MaterialApp(
        theme: theme,
        home: SearchScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
