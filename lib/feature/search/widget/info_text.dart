import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Center(
        child: title != null ? Text(title!) : CircularProgressIndicator(),
      ),
    );
  }
}