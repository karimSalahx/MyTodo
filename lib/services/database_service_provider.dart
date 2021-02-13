import 'package:flutter/cupertino.dart';
import 'package:my_todo/database/sqlite_helper.dart';
import 'package:my_todo/models/note.dart';

class DatabaseServiceProvider extends ChangeNotifier {
  SqliteHelper _sqliteHelper = SqliteHelper.instance;
  int _finishedCounter = 0;
  int get finishedCounter => _finishedCounter;

  Future<int> insert(Note note) async {
    final res = await _sqliteHelper.insert(note.toMap());
    notifyListeners();
    return res;
  }

  Future<List<Note>> getAllData() async {
    List<Note> _list = [];
    final sqlQueries = await _sqliteHelper.queryAll();
    for (var query in sqlQueries) {
      _list.add(Note.fromMap(query));
    }
    _list.sort();
    print(_list);
    return _list;
  }

  Future<int> update(Note note) async {
    final res = await _sqliteHelper.update(note.toMap());
    notifyListeners();
    return res;
  }

  Future<void> finishTask(Note note) async {
    note.isFinished = 1;
    _finishedCounter++;
    notifyListeners();
    await update(note);
  }

  Future<void> undoTask(Note note) async {
    note.isFinished = 0;
    _finishedCounter--;
    notifyListeners();
    await update(note);
  }

  Future<int> delete(Note note) async {
    if (note.isFinished == 1) _finishedCounter--;
    final res = await _sqliteHelper.delete(note.id);
    notifyListeners();
    return res;
  }
}
