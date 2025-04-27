import 'books.dart';

abstract interface class BooksRepositoryI {
  Future<Books> fetchBooksList(String query, int page);
}