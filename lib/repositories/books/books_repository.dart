import 'dart:convert';
import 'package:flutter/material.dart';

import 'books.dart';
import 'package:http/http.dart';

const limit = 20;

class BooksRepository implements BooksRepositoryI {
  BooksRepository({required this.client});

  final Client client;

  @override
  Future<Books> fetchBooksList(String query, int page) async {
    final uri = Uri.https('openlibrary.org', '/search.json', {
      'q': query,
      'limit': '$limit',
      'page': '$page',
    });
    try {
      final response = await client.get(uri);

      if (response.statusCode != 200) {
        debugPrint('response.body: ${response.body}');
        throw Exception('Ошибка загрузки списка книг');
      }

      final json = jsonDecode(response.body);
      return Books.fromJson(json);
    } catch (e) {
      throw Exception(e);
    }
  }
}
