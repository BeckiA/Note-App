import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../helper/note_provider.dart';
import '../models/note.dart';
import '../utils/constants.dart';
import '../widgets/delete_popup.dart';
import 'note_edit_screen.dart';

class NoteViewScreen extends StatefulWidget {
  static const route = '/note-view';
  const NoteViewScreen({super.key});

  @override
  _NoteViewScreenState createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State {
  late Note selectedNote;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final id = ModalRoute.of(context)?.settings.arguments;

    final provider = Provider.of<NoteProvider>(context);

    if (provider.getNote(id as int) != null) {
      selectedNote = provider.getNote(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.7,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () => _showDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                selectedNote.title,
                style: viewTitleStyle,
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.access_time,
                    size: 18,
                  ),
                ),
                Text(selectedNote.date)
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: selectedNote.imagePath == null
                    ? const SizedBox.shrink()
                    : Image.file(
                        File(selectedNote.imagePath),
                        fit: BoxFit.cover,
                      )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                selectedNote.content,
                style: viewContentStyle,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NoteEditScreen.route,
              arguments: selectedNote.id);
        },
        child: Icon(Icons.edit),
      ),
    );
  }

  _showDialog() {
    showDialog(
        context: this.context,
        builder: (context) {
          return DeletePopUp(selectedNote: selectedNote);
        });
  }
}
