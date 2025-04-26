part of 'books_list_bloc.dart';

sealed class BooksListEvent extends Equatable {
  const BooksListEvent();

  @override
  List<Object?> get props => [];
}

class SearchBook extends BooksListEvent {
  const SearchBook({required this.query});

  final String query;

  @override
  List<Object?> get props => super.props..add(query);
}

class LoadPage extends BooksListEvent {}
