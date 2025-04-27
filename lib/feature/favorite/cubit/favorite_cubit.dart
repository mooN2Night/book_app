import 'package:book_app/repositories/favorite/favorite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_app/repositories/books/books.dart';

class FavoriteCubit extends Cubit<List<Book>> {
  FavoriteCubit({required FavoriteRepositoryI favoriteRepository})
    : _favoriteRepository = favoriteRepository,
      super([]) {
    loadFavorites();
  }

  final FavoriteRepositoryI _favoriteRepository;

  Future<void> loadFavorites() async {
    final favorites = await _favoriteRepository.getFavorites();
    emit(favorites);
  }

  Future<void> addToFavorite(Book book) async {
    await _favoriteRepository.addBookToFavorite(book);
    final updatedFavorites = await _favoriteRepository.getFavorites();
    emit(updatedFavorites);
  }

  Future<void> deleteFromFavorite(Book book) async {
    await _favoriteRepository.deleteBookFromFavorite(book);
    final updatedFavorites = await _favoriteRepository.getFavorites();
    emit(updatedFavorites);
  }
}
