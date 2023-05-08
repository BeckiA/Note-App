import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NoteViewScreen extends StatefulWidget {
  static const route = '/note-view';
  const NoteViewScreen({super.key});

  @override
  State<NoteViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
