import 'dart:async';
import 'models/word.dart';
import 'models/word_item.dart';
import 'package:rxdart/subjects.dart';

class WordAddition {
  final String name;
  WordAddition(this.name);
}

class WordRemove {
  final String name;
  WordRemove(this.name);
}

class WordBloc {
  final Word _word = Word();

  final BehaviorSubject<List<WordItem>> _items =
      BehaviorSubject<List<WordItem>>.seeded(const []);

  final BehaviorSubject<int> _itemCount = BehaviorSubject<int>.seeded(0);
  // BehaviorSubject : 『最新の値が追加されたら、それを購読者に発行する』

  final StreamController<WordAddition> _wordAdditionController =
      StreamController<WordAddition>();

  final StreamController<WordRemove> _wordRemoveController =
      StreamController<WordRemove>();

  WordBloc() {
    _wordAdditionController.stream.listen((addition) {
      int currentCount = _word.itemCount;
      _word.add(addition.name);
      _items.add(_word.items);
      int updateCount = _word.itemCount;
      if (updateCount != currentCount) {
        _itemCount.add(updateCount); // 更新
      }
    });

    _wordRemoveController.stream.listen((remove) {
      int currentCount = _word.itemCount;
      _word.remove(remove.name);
      print(_word.items.toString());
      _items.add(_word.items);
      int updateCount = _word.itemCount;
      if (updateCount != currentCount) {
        _itemCount.add(updateCount); // 更新
      }
    });
  }

  Sink<WordAddition> get wordAddition => _wordAdditionController.sink;

  Sink<WordRemove> get wordRemove => _wordRemoveController.sink;

  Stream<int> get itemCount => _itemCount.stream;

  Stream<List<WordItem>> get items => _items.stream;

  void dispose() {
    _items.close();
    _itemCount.close();
    _wordAdditionController.close();
    _wordRemoveController.close();
  }
}
