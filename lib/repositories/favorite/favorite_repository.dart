import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../books/books.dart';
import 'favorite.dart';

class FavoriteRepository implements FavoriteRepositoryI {
  FavoriteRepository({required this.prefs});

  final SharedPreferences prefs;
  static const _favoriteKey = 'favorite_books';

  @override
  Future<void> addBookToFavorite(Book book) async {
    final currentFavorites = prefs.getStringList(_favoriteKey) ?? [];
    final updatedFavorites = [...currentFavorites, jsonEncode(book.toJson())];
    await prefs.setStringList(_favoriteKey, updatedFavorites);
  }

  @override
  Future<void> deleteBookFromFavorite(Book book) async {
    final currentFavorites = prefs.getStringList(_favoriteKey) ?? [];
    final updatedFavorites =
        currentFavorites.where((item) {
          final decoded = Book.fromJson(jsonDecode(item));
          return decoded.title != book.title;
        }).toList();
    await prefs.setStringList(_favoriteKey, updatedFavorites);
  }

  @override
  Future<List<Book>> getFavorites() async {
    final currentFavorites = prefs.getStringList(_favoriteKey) ?? [];
    return currentFavorites
        .map((favorite) => Book.fromJson(jsonDecode(favorite)))
        .toList();
  }
}
