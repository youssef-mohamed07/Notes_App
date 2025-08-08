import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/notes_item.dart';

import 'edit_notes_view.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<NoteModel>>(
      valueListenable: Hive.box<NoteModel>(kNoteBox).listenable(),
      builder: (context, box, _) {
        if (box.isEmpty) {
          return const Center(
            child: Text(
              'No notes available',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        }

        // Sort notes by date (latest first)
        final notes = box.values.toList()
          ..sort((a, b) => b.date.compareTo(a.date));

        return ListView.separated(
          itemCount: notes.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          separatorBuilder: (context, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final note = notes[index];

            return Dismissible(
              key: ValueKey(note.key),
              background: Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) {
                note.delete();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Note deleted'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditNoteView(
                        noteIndex: index,
                        note: note,
                      ),
                    ),
                  );
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: NotesItem(note: note, index: index),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
