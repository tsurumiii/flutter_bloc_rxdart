import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import './bloc_favorite_page.dart';
import './word_provider.dart';
import './word_bloc.dart';
import './models/word_item.dart';
import './models/suggestion.dart';
import './widgets/count_label.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

Xml2Json xml2json = new Xml2Json();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WordProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // primarySwatch: Colors.white,
            ),
        home: RandomWordsHomePage(),
      ),
    );
  }
}

class RandomWordsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordBloc = WordProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator (Bloc rxdart)'),
        actions: <Widget>[
          StreamBuilder<int>(
            stream: wordBloc.itemCount,
            initialData: 0,
            builder: (context, snapshot) => CountLabel(
                  favoriteCount: snapshot.data,
                ),
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => BlocFavoritePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: WordList(),
    );
  }
}

class WordList extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= suggestion.suggestionCount) {
          const addNum = 10;
          suggestion.addMulti(generateWordPairs().take(addNum).toList());
        }
        return _buildRow(
            WordProvider.of(context), suggestion.suggestedWords[index]);
      },
    );
  }
}

Widget _buildRow(WordBloc word, WordPair pair) {
  return StreamBuilder<List<WordItem>>(
    stream: word.items,
    builder: (_, snapshot) {
      if (snapshot.data == null || snapshot.data.isEmpty) {
        return _createWordListTile(word, false, pair.asPascalCase);
      } else {
        final addedWord = snapshot.data.map((item) {
          return item.name;
        });
        final aleleadyAdded = addedWord.toString().contains(pair.asPascalCase);
        return _createWordListTile(word, aleleadyAdded, pair.asPascalCase);
      }
    },
  );
}

ListTile _createWordListTile(WordBloc word, bool isFavorited, String title) {
  return ListTile(
    title: Text(title),
    trailing: Icon(
      isFavorited ? Icons.favorite : Icons.favorite_border,
      color: isFavorited ? Colors.red : null,
    ),
    onTap: () {
      if (isFavorited) {
        word.wordRemove.add(WordRemove(title));
      } else {
        word.wordAddition.add(WordAddition(title));
        print('aa');
        print(title);
      }
    },
  );
}
