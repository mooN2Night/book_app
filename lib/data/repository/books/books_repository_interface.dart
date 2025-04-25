import 'package:book_app/data/repository/books/models/models.dart';

abstract interface class BooksRepositoryI {
  Future<Books> fetchBooksList(String query, int page);
}