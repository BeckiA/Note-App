import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:note_app/screens/note_add_screen.dart';
import 'package:note_app/screens/note_edit_screen.dart';
import 'package:note_app/screens/note_list_screen.dart';
import 'package:note_app/screens/note_view_screen.dart';
import 'package:provider/provider.dart';

import 'helper/note_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NoteController noteProvider = NoteController();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "My Notes",
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => const NoteListScreen(),
          ),
          GetPage(
            name: '/note-view',
            page: () => NoteViewScreen(),
          ),
          GetPage(
            name: '/note-add',
            page: () => NoteAddScreen(),
          ),
          GetPage(
            name: '/note-edit',
            page: () => NoteEditScreen(),
          )
        ]);
  }
}
