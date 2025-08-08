// edit_note_view.dart
import 'package:flutter/material.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/edit_note_body.dart';

class EditNoteView extends StatelessWidget {
  final int noteIndex;
  final NoteModel note;

  const EditNoteView({
    super.key,
    required this.noteIndex,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Note")),
      body: EditNoteBody(
        noteIndex: noteIndex,
        note: note,
      ),
    );
  }
}
