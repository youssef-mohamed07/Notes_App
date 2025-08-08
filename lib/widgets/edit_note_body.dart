// edit_note_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/note_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/custom_text_field.dart';
import 'package:notes_app/widgets/custom_button.dart';

class EditNoteBody extends StatefulWidget {
  final int noteIndex;
  final NoteModel note;

  const EditNoteBody({
    super.key,
    required this.noteIndex,
    required this.note,
  });

  @override
  State<EditNoteBody> createState() => _EditNoteBodyState();
}

class _EditNoteBodyState extends State<EditNoteBody> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.subTitle);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> saveNote() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot save an empty note'),
        backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      // Use the cubit to update so UI/state refresh properly
      await context.read<NoteCubit>().updateNote(
        widget.note,
        title: title,
        subTitle: content,
        updateDate: true,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note updated successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while saving: $e'),
        backgroundColor: Colors.red,),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            CustomTextField(
              hint: 'Title',
              controller: titleController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hint: 'Content',
              maxLines: 6,
              controller: contentController,
            ),
            const SizedBox(height: 24),
            CustomButton(
              label: _saving ? 'Saving...' : 'Save',
              onTap: _saving ? () {} : saveNote,
            )
          ],
        ),
      ),
    );
  }
}
