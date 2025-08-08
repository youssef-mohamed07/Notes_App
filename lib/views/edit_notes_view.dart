import 'package:flutter/material.dart';

import '../widgets/edit_note_body.dart';

class EditNoteView extends StatelessWidget {
  const EditNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Note")),
      body: const EditNoteBody(
        initialTitle: 'My Note Title',
        initialContent: 'This is my existing note content...',
      ),
    );
  }
}
