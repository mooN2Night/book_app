part of 'books_list_bloc.dart';

sealed class BooksListState extends Equatable {
  const BooksListState();

  @override
  List<Object> get props => [];
}

final class BooksListInitial extends BooksListState {}

final class BooksListLoading extends BooksListState {}

final class BooksListLoaded extends BooksListState {
  const BooksListLoaded({
    required this.books,
    required this.favorites,
    required this.currentPage,
    required this.hasReachedMax,
  });

  final List<Book> books;
  final List<Book> favorites;
  final int currentPage;
  final bool hasReachedMax;

  Book? favorite(String title) {
    return favorites.firstWhereOrNull((e) => e.title == title);
  }

  @override
  List<Object> get props =>
      super.props..addAll([books, favorites, currentPage, hasReachedMax]);

  BooksListLoaded copyWith({
    List<Book>? books,
    List<Book>? favorites,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return BooksListLoaded(
      books: books ?? this.books,
      favorites: favorites ?? this.favorites,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

final class BooksListEmpty extends BooksListState {
  const BooksListEmpty({required this.query});

  final String query;

  @override
  List<Object> get props => super.props..add(query);
}

final class BooksListFailure extends BooksListState {
  const BooksListFailure({required this.error});

  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
