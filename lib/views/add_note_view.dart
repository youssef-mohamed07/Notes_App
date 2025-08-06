import 'package:flutter/material.dart';

class AddNoteView extends StatelessWidget {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextField(
            decoration: InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 8),
          const TextField(
            maxLines: 4,
            decoration: InputDecoration(labelText: 'Content'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // تنفيذ منطق الحفظ هنا
              Navigator.pop(context);
            },
            child: const Text('Save Note'),
          ),
        ],
      ),
    );
  }
}
