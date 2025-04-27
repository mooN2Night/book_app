import 'package:book_app/core/widgets/widgets.dart';
import 'package:book_app/feature/favorite/cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/books/books.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Избранное'), centerTitle: true),
      body: BlocBuilder<FavoriteCubit, List<Book>>(
        builder: (context, favorites) {
          if (favorites.isEmpty) {
            return Center(child: Text('Пока нет избранных книг'));
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final book = favorites[index];
              return BookTile(
                book: book,
                deleteIcon: Icons.delete,
              );
            },
          );
        },
      ),
    );
  }
}
