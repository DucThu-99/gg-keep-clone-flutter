import 'package:flutter/foundation.dart';
import 'package:gg_keep_clone/models/note.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteListProvider with ChangeNotifier {
  List<Note> _items = [];
  List<Note> _deletedNotes = [];

  List<Note> get items {
    return _items;
  }

  List<Note> get deletedNotes {
    return _deletedNotes;
  }

  Database _database;

  ///IMPORTANT: Call this function when the app is start up
  ///This function create/open the database and initiate the notes list.
  Future<void> onStartup() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes_database.db');

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
        'CREATE TABLE notes (id TEXT PRIMARY KEY, title TEXT, content TEXT, day INTEGER, month INTEGER, year INTEGER, alive INTEGER)',
      );
    });

    List<Map<String, Object>> list = await _database.query('notes',
        columns: ['id', 'title', 'content', 'day', 'month', 'year'],
        where: 'alive = ?',
        whereArgs: [1]);
    _items = List<Note>.generate(
      list.length,
      (index) => Note(
        id: list[index]['id'],
        title: list[index]['title'],
        content: list[index]['content'],
        lastModify: DateTime(
            list[index]['year'], list[index]['month'], list[index]['day']),
      ),
    );

    List<Map<String, Object>> deletedList = await _database.query('notes',
        columns: ['id', 'title', 'content', 'day', 'month', 'year'],
        where: 'alive = ?',
        whereArgs: [0]);
    _deletedNotes = List<Note>.generate(
      deletedList.length,
      (index) => Note(
        id: deletedList[index]['id'],
        title: deletedList[index]['title'],
        content: deletedList[index]['content'],
        lastModify: DateTime(deletedList[index]['year'],
            deletedList[index]['month'], deletedList[index]['day']),
      ),
    );
  }

  ///Get the String value of last time modify
  String getLastModify(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  ///Get detail that just modify and save it in the _items
  Future<void> saveNote(
    String id,
    String title,
    String content,
    DateTime dateModify,
  ) async {
    if (title == null) {
      title = _extractTitle(content);
    }

    int index = _items.indexWhere((item) => item.id == id);

    if (index == -1) {
      Note note =
          Note(id: id, title: title, content: content, lastModify: dateModify);
      _items.add(note);
      await _insertNote(note);
    } else {
      _items[index].title = title;
      _items[index].content = content;
      _items[index].lastModify = dateModify;
      await _updateNote(_items[index]);
    }
    notifyListeners();
  }

  Future<void> _insertNote(Note note) async {
    await _database.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> _updateNote(Note note) async {
    await _database.update(
      'notes',
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }

  String _extractTitle(String content) {
    LineSplitter splitter = LineSplitter();
    String title = splitter.convert(content)[0];
    return title;
  }

  Note getNoteWithId(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void deleteNotesTemporary(List<String> idNotes) {
    for (String idNote in idNotes) {
      int index = _items.indexWhere((item) => item.id == idNote);
      if (index != -1) {
        _hideNote(_items[index]);
        _items.removeAt(index);
      }
    }
    notifyListeners();
  }

  Future<void> _hideNote(Note note) async {
    await _database.update(
      'notes',
      note.toMapDelete(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }
}
