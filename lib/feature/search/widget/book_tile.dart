import 'package:flutter/material.dart';

import '../../../data/repository/books/books.dart';

class BookTile extends StatefulWidget {
  const BookTile({super.key, required this.book});

  final Book book;

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  bool _isFavorite = false;
  double _iconScale = 1.0;

  void _onFavoriteToggle() async {
    setState(() {
      _iconScale = 1.5;
      _isFavorite = !_isFavorite;
    });

    await Future.delayed(Duration(milliseconds: 130));
    setState(() {
      _iconScale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authors = widget.book.authorName?.map((author) => author).join(', ');

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.book.image != null
              ? Image.network(widget.book.fullImage, width: 200)
              : Image.asset('assets/images/no_picture.png', width: 200),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ).copyWith(left: 10, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(widget.book.title)),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: _onFavoriteToggle,
                        child: AnimatedScale(
                          scale: _iconScale,
                          duration: Duration(milliseconds: 150),
                          curve: Curves.easeInOut,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 150),
                            child: Icon(
                              _isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _isFavorite ? Colors.red : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  if (widget.book.authorName != null) Text(authors!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// AnimatedScale(
// scale: _isPressed ? 1 : 0.8,
// duration: Duration(seconds: 1),
// child: Icon(Icons.favorite_border),
// ),
