import 'package:flutter/material.dart';
import 'package:notes_app/widgets/custom_text_field.dart';
import 'package:notes_app/widgets/custom_button.dart';

class EditNoteBody extends StatefulWidget {
  final String initialTitle;
  final String initialContent;

  const EditNoteBody({
    super.key,
    required this.initialTitle,
    required this.initialContent,
  });

  @override
  State<EditNoteBody> createState() => _EditNoteBodyState();
}

class _EditNoteBodyState extends State<EditNoteBody> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.initialTitle);
    contentController = TextEditingController(text: widget.initialContent);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
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
              label: 'Save',
              onTap: () {
                final updatedTitle = titleController.text;
                final updatedContent = contentController.text;

                // نفذ الحفظ هنا (مثلاً باستخدام Hive أو أي تخزين)
                print('Saved: $updatedTitle - $updatedContent');

                Navigator.pop(context); // اغلق الصفحة بعد الحفظ
              },
            ),
          ],
        ),
      ),
    );
  }
}
