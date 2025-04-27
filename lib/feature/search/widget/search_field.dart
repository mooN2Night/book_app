import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: _searchController,
      cursorColor: theme.colorScheme.primary,
      decoration: InputDecoration(
        hintText: 'Поиск книг...',
      ),
    );
  }
}
