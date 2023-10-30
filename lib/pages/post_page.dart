import 'package:flutter/material.dart';
import 'package:letmecook/widgets/topAppBar.dart';
import 'package:letmecook/widgets/btmNavBar.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAppBar = myAppBar();
    final _btmNavBar = btmNavBar();

    return Scaffold(
      appBar: topAppBar,
      bottomNavigationBar: _btmNavBar,
      body: Text('Post Something'),
    );
  }
}
