import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/favorite/cubit/favorite_cubit.dart';
import '../../feature/search/bloc/books_list_bloc.dart';
import '../../repositories/books/books.dart';
import '../../repositories/favorite/favorite.dart';

class AppInitializer extends StatelessWidget {
  const AppInitializer({
    super.key,
    required this.client,
    required this.prefs,
    required this.child,
  });

  final Client client;
  final SharedPreferences prefs;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BooksRepositoryI>(
          create: (context) => BooksRepository(client: client),
        ),
        RepositoryProvider<FavoriteRepositoryI>(
          create: (context) => FavoriteRepository(prefs: prefs),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => FavoriteCubit(
                  favoriteRepository: context.read<FavoriteRepositoryI>(),
                ),
          ),
          BlocProvider(
            create:
                (context) => BooksListBloc(
                  booksRepository: context.read<BooksRepositoryI>(),
                  favoriteRepository: context.read<FavoriteRepositoryI>(),
                ),
          ),
        ],
        child: child,
      ),
    );
  }
}
