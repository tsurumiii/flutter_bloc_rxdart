import '../models/word_item.dart';
import 'dart:collection';

class Word {
  final List<WordItem> _items = <WordItem>[];

  Word();

  Word.clone(Word word) {
    _items.addAll(word._items);
  }

  int get itemCount => _items.length;

  UnmodifiableListView<WordItem> get items => UnmodifiableListView(_items);

  void add(String name) {
    print('3: word.add $name');
    _updateCountAdd(name);
  }

  void remove(String name) {
    _updateRemove(name);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$items";
  }

  void _updateCountAdd(String name) {
    print('4:  _updateCountAdd $name');
    for (int i = 0; i < _items.length; i++) {
      final item = _items[i];
      if (name == item.name) {
        return;
      }
    }
    _items.add(WordItem(name));
    print('5: _items.length: ${_items.length}');
  }

  void _updateRemove(String name) {
    for (int i = 0; i < _items.length; i++) {
      final item = _items[i];
      if (name == item.name) {
        _items.removeAt(i);
      }
    }
  }
}
