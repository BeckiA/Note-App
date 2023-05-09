import 'package:flutter/material.dart';
import 'package:note_app/helper/database_helper.dart';

import '../models/note.dart';
import '../utils/constants.dart';

class NoteProvider with ChangeNotifier {
  List _items = [];
  List get items {
    return [..._items];
  }

  Future getNotes() async {
    final noteList = await DatabaseHelper.getNotesFromDB();
    _items = noteList
        .map((item) => Note(
            id: item['id'],
            title: item['title'],
            content: item['content'],
            imagePath: item['imagePath']))
        .toList();

    notifyListeners();
  }

  Note getNote(int id) {
    return _items.firstWhere((note) => note.id == id);
  }

  Future deleteNote(int id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    return DatabaseHelper.delete(id);
  }

  Future addOrUpdateNote(int id, String title, String content, String imagePath,
      EditMode editMode) async {
    final note =
        Note(id: id, title: title, content: content, imagePath: imagePath);

    if (EditMode.ADD == editMode) {
      _items.insert(0, note);
    } else {
      _items[_items.indexWhere((note) => note.id == id)] = note;
    }

    notifyListeners();

    DatabaseHelper.insert(
      {
        'id': note.id,
        'title': note.title,
        'content': note.content,
        'imagePath': note.imagePath,
      },
    );
  }
}
