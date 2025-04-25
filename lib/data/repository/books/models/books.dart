import 'package:json_annotation/json_annotation.dart';

part 'books.g.dart';

@JsonSerializable()
class Books {
  @JsonKey(name: 'docs')
  final List<Book> books;

  Books({required this.books});

  factory Books.fromJson(Map<String, dynamic> json) => _$BooksFromJson(json);

  Map<String, dynamic> toJson() => _$BooksToJson(this);
}

@JsonSerializable()
class Book {
  @JsonKey(name: 'author_name')
  final List<String>? authorName;
  @JsonKey(name: 'cover_i')
  final int? image;
  final String title;

  String get fullImage => 'https://covers.openlibrary.org/b/id/$image-M.jpg';

  Book({required this.authorName, required this.image, required this.title});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}
