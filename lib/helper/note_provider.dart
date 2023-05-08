import 'package:flutter/material.dart';
import 'package:note_app/helper/database_helper.dart';

import '../models/note.dart';

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
}
