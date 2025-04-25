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
    required this.currentPage,
    required this.hasReachedMax,
  });

  final List<Book> books;
  final int currentPage;
  final bool hasReachedMax;

  @override
  List<Object> get props =>
      super.props..addAll([books, currentPage, hasReachedMax]);

  BooksListLoaded copyWith({
    List<Book>? books,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return BooksListLoaded(
      books: books ?? this.books,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

final class BooksListFailure extends BooksListState {
  const BooksListFailure({required this.error});

  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
