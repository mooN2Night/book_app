import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/repository/books/books.dart';

part 'books_list_event.dart';

part 'books_list_state.dart';

class BooksListBloc extends Bloc<BooksListEvent, BooksListState> {
  BooksListBloc({required BooksRepositoryI booksRepository})
    : _booksRepository = booksRepository,
      super(BooksListInitial()) {
    on<SearchBook>(
      _onSearch,
      transformer: debounceDroppable(Duration(milliseconds: 500)),
    );
    on<LoadPage>(_onLoadPage);
  }

  final BooksRepositoryI _booksRepository;
  String _currentQuery = '';
  static const _limit = 20;

  Future<void> _onSearch(SearchBook event, Emitter<BooksListState> emit) async {
    _currentQuery = event.query;

    if (_currentQuery.isEmpty) {
      emit(BooksListInitial());
      return;
    }

    emit(BooksListLoading());

    try {
      final result = await _booksRepository.fetchBooksList(_currentQuery, 1);
      emit(
        BooksListLoaded(
          books: result.books,
          currentPage: 1,
          hasReachedMax: result.books.length < _limit,
        ),
      );
    } catch (e) {
      emit(BooksListFailure(error: e));
    }
  }

  FutureOr<void> _onLoadPage(
    LoadPage event,
    Emitter<BooksListState> emit,
  ) async {
    final currentState = state;

    if (currentState is BooksListLoaded && !currentState.hasReachedMax) {
      try {
        final nextPage = currentState.currentPage + 1;
        final result = await _booksRepository.fetchBooksList(
          _currentQuery,
          nextPage,
        );

        final allBooks = List<Book>.from(currentState.books)
          ..addAll(result.books);

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
  }

  EventTransformer<SearchBook> debounceDroppable<SearchBook>(
    Duration duration,
  ) {
    return (events, mapper) =>
        events.debounceTime(duration).distinct().switchMap(mapper);
  }
}
