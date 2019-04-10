import 'package:flutter/material.dart';
import '../models/word.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage(this.word);
  final Word word;
  @override
  Widget build(BuildContext context) {
    final tiles = word.items.map(
      (f) {
        return ListTile(
          title: Text(f.name),
        );
      },
    );

    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('お気に入りリスト'),
      ),
      body: ListView(
        children: divided,
      ),
    );
  }
}
