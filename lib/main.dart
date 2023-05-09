import 'package:flutter/material.dart';
import 'package:note_app/screens/note_edit_screen.dart';
import 'package:note_app/screens/note_list_screen.dart';
import 'package:note_app/screens/note_view_screen.dart';
import 'package:provider/provider.dart';

import 'helper/note_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NoteProvider noteProvider = NoteProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: noteProvider,
      child: MaterialApp(
        title: "My Notes",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const NoteListScreen(),
          NoteViewScreen.route: (context) => const NoteViewScreen(),
          NoteEditScreen.route: (context) => NoteEditScreen(),
        },
      ),
    );
  }
}
