import 'package:book_app/feature/search/bloc/books_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchBooks);
    _scrollController.addListener(_onLoadPage);
  }

  void _onSearchBooks() {
    final query = _searchController.text.trim();

    context.read<BooksListBloc>().add(SearchBook(query: query));
  }

  void _onLoadPage() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<BooksListBloc>().add(LoadPage());
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            centerTitle: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text('Open Library'),
            toolbarHeight: 30,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(75),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SearchField(searchController: _searchController),
              ),
            ),
          ),
          BlocBuilder<BooksListBloc, BooksListState>(
            builder: (context, state) {
              if (state is BooksListInitial) {
                return SliverToBoxAdapter(
                  child: Info(title: 'Скорее начните искать любимые книги'),
                );
              }
              if (state is BooksListLoading) {
                return SliverToBoxAdapter(child: Info());
              }
              if (state is BooksListFailure) {
                return SliverToBoxAdapter(
                  child: Info(title: 'Ошибка: ${state.error}'),
                );
              }
              if (state is BooksListLoaded) {
                final books = state.books;
                final isEnd = state.hasReachedMax;

                return SliverList.builder(
                  itemCount: isEnd ? books.length : books.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= books.length) {
                      return Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final book = state.books[index];
                    return BookTile(book: book);
                  },
                );
              }

              return SliverToBoxAdapter(
                child: Info(title: 'Скорее начните искать любимые книги'),
              );
            },
          ),
        ],
      ),
    );
  }
}
