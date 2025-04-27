import 'package:book_app/feature/search/bloc/books_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/books/books.dart';
import '../../feature/favorite/cubit/favorite_cubit.dart';

class BookTile extends StatefulWidget {
  const BookTile({
    super.key,
    required this.book,
    this.deleteIcon,
    this.isFavorite = false,
  });

  final Book book;
  final bool? isFavorite;
  final IconData? deleteIcon;

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  bool _isFavorite = false;
  double _iconScale = 1.0;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite ?? false;
  }

  void _onFavoriteToggle(BuildContext context, Book book) async {
    setState(() {
      _iconScale = 1.5;
      _isFavorite = !_isFavorite;
    });

    if (_isFavorite) {
      await context.read<FavoriteCubit>().addToFavorite(book);
    } else {
      await context.read<FavoriteCubit>().deleteFromFavorite(book);
    }

    await Future.delayed(Duration(milliseconds: 130));
    setState(() {
      _iconScale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authors = widget.book.authorName?.join(', ');
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: theme.colorScheme.onPrimary,
      ),
      height: 320,
      padding: EdgeInsets.only(right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.book.image != null
              ? _imageContainer(NetworkImage(widget.book.fullImage))
              : _imageContainer(AssetImage('assets/images/no_picture.png')),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.book.title,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(width: 5),
                    widget.deleteIcon != null
                        ? _deleteFromFavoriteIcon(context, widget.book)
                        : _addToFavoriteIcon(context),
                  ],
                ),
                SizedBox(height: 20),
                if (widget.book.authorName != null)
                  Text(authors!, style: theme.textTheme.labelMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _addToFavoriteIcon(BuildContext context) {
    return GestureDetector(
      onTap: () => _onFavoriteToggle(context, widget.book),
      child: AnimatedScale(
        scale: _iconScale,
        duration: Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: Icon(
          _isFavorite ? Icons.favorite : Icons.favorite_border,
          color: _isFavorite ? Colors.red : Colors.black.withValues(alpha: 0.8),
        ),
      ),
    );
  }

  GestureDetector _deleteFromFavoriteIcon(BuildContext context, Book book) {
    return GestureDetector(
      onTap: () => context.read<FavoriteCubit>().deleteFromFavorite(book),
      child: Icon(widget.deleteIcon, color: Colors.red),
    );
  }

  Container _imageContainer(ImageProvider image) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 190,
      height: 300,
      decoration: BoxDecoration(image: DecorationImage(image: image)),
    );
  }
}
