import 'dart:async';

import 'package:book_app/core/core.dart';
import 'package:book_app/repositories/favorite/favorite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../repositories/books/books.dart';

part 'books_list_event.dart';

part 'books_list_state.dart';

class BooksListBloc extends Bloc<BooksListEvent, BooksListState> {
  BooksListBloc({
    required BooksRepositoryI booksRepository,
    required FavoriteRepositoryI favoriteRepository,
  }) : _booksRepository = booksRepository,
       _favoriteRepository = favoriteRepository,
       super(BooksListInitial()) {
    on<SearchBook>(_onSearch, transformer: _debounceDroppable());
    on<LoadPage>(_onLoadPage);
  }

  final BooksRepositoryI _booksRepository;
  final FavoriteRepositoryI _favoriteRepository;
  String _currentQuery = '';
  static const _limit = 20;

  Future<void> _onSearch(SearchBook event, Emitter<BooksListState> emit) async {
    _currentQuery = event.query;

    if (_currentQuery.isEmpty) {
      emit(BooksListInitial());
      return;
    }

    //Проверка добавлена потому, что иногда на отправку 1 символа OpenLibrary
    // отдает не json, а HTML страницу.
    if (_currentQuery.length < 2) {
      emit(BooksListInitial());
      return;
    }

    emit(BooksListLoading());

    try {
      final result = await _booksRepository.fetchBooksList(_currentQuery, 1);
      final favorites = await _favoriteRepository.getFavorites();

      if (result.books.isEmpty) {
        emit(BooksListEmpty(query: _currentQuery));
        return;
      }

      emit(
        BooksListLoaded(
          books: result.books,
          favorites: favorites,
          currentPage: 1,
          hasReachedMax: result.books.length < _limit,
        ),
      );
    } catch (e) {
      emit(BooksListFailure(error: e));
    }
  }

  Future<void> _onLoadPage(LoadPage event, Emitter<BooksListState> emit) async {
    final currentState = state;

    if (currentState is! BooksListLoaded || currentState.hasReachedMax) return;

    try {
      final nextPage = currentState.currentPage + 1;
      final result = await _booksRepository.fetchBooksList(
        _currentQuery,
        nextPage,
      );

      final allBooks = [...currentState.books, ...result.books];

      emit(
        currentState.copyWith(
          books: allBooks,
          currentPage: nextPage,
          hasReachedMax: result.books.length < _limit,
        ),
      );
    } catch (e) {
      emit(BooksListFailure(error: e));
    }
  }

  EventTransformer<SearchBook> _debounceDroppable<SearchBook>() {
    return (events, mapper) => events
        .debounceTime(Duration(milliseconds: 500))
        .distinct()
        .switchMap(mapper);
  }
}
