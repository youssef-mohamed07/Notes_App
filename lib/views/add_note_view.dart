import 'package:flutter/material.dart';
import 'package:notes_app/widgets/add_note_form.dart';

class AddNoteView extends StatelessWidget {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
      ),
      child: const SingleChildScrollView(
        child: AddNoteForm(),
      ),
    );
  }
}
