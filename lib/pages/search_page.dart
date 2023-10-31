import 'package:flutter/material.dart';
import 'package:letmecook/widgets/topAppBar.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAppBar = myAppBar();


    return Scaffold(

      body: Text('Search'),
    );
  }
}
