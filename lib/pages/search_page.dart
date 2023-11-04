import 'package:flutter/material.dart';
import 'package:letmecook/widgets/top_appbar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAppBar = MyAppBar();

    return Scaffold(
      body: Text('Search'),
    );
  }
}
