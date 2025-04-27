// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Books _$BooksFromJson(Map<String, dynamic> json) => Books(
  books:
      (json['docs'] as List<dynamic>)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$BooksToJson(Books instance) => <String, dynamic>{
  'docs': instance.books,
};

Book _$BookFromJson(Map<String, dynamic> json) => Book(
  authorName:
      (json['author_name'] as List<dynamic>?)?.map((e) => e as String).toList(),
  image: (json['cover_i'] as num?)?.toInt(),
  title: json['title'] as String,
);

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
  'author_name': instance.authorName,
  'cover_i': instance.image,
  'title': instance.title,
};
