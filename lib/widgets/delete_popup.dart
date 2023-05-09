import 'package:flutter/material.dart';
import '../helper/note_provider.dart';
import '../models/note.dart';
import 'package:provider/provider.dart';

class DeletePopUp extends StatelessWidget {
  const DeletePopUp({
    required this.selectedNote,
  });

  final Note selectedNote;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text('Delete?'),
      content: Text('Do you want to delete the note?'),
      actions: [
        TextButton(
          child: const Text('Yes'),
          onPressed: () {
            Provider.of<NoteProvider>(context, listen: false)
                .deleteNote(selectedNote.id);
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        TextButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
