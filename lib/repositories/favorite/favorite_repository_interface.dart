import '../books/books.dart';

abstract interface class FavoriteRepositoryI {
  Future<void> addBookToFavorite(Book book);
  Future<void> deleteBookFromFavorite(Book book);
  Future<List<Book>> getFavorites();
}