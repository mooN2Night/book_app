import 'package:book_app/data/repository/books/books.dart';
import 'package:book_app/data/repository/books/books_repository.dart';
import 'package:book_app/feature/search/bloc/books_list_bloc.dart';
import 'package:book_app/feature/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class BookApp extends StatelessWidget {
  const BookApp({super.key, required this.client});

  final Client client;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BooksRepositoryI>(
          create: (context) => BooksRepository(client: client),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => BooksListBloc(
                  booksRepository: context.read<BooksRepositoryI>(),
                ),
          ),
        ],
        child: MaterialApp(
          home: SearchScreen(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white70,
            appBarTheme: AppBarTheme(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
              )
            ),
          ),
        ),
      ),
    );
  }
}
