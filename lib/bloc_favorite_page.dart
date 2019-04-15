import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './models/word_item.dart';
import './word_provider.dart';

class BlocFavoritePage extends StatelessWidget {
  BlocFavoritePage();
  @override
  Widget build(BuildContext context) {
    final word = WordProvider.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('ファボ'),
      ),
      body: StreamBuilder<List<WordItem>>(
        stream: word.items,
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data.isEmpty) {
            return Container(
              height: height,
              width: width,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text('まだお気に入りに追加されてません。'),
                    _svgImage(context),
                  ],
                ),
              ),
            );
          }
          final tiles = snapshot.data.map((f) {
            return ListTile(
              title: Text(f.name),
            );
          });

          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return ListView(
            children: divided,
          );
        },
      ),
    );
  }
}

Widget _svgImage(BuildContext context) {
  final String assetName = 'images/codecov.svg';
  return Container(
    padding: EdgeInsets.all(20),
    height: 200,
    width: 200,
    child: SvgPicture.asset(
      assetName,
      color: Colors.amber,
    ),
  );
}
