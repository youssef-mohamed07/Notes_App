import 'package:flutter/material.dart';
import 'package:notes_app/views/notes_view_body.dart';
import 'package:notes_app/widgets/custom_floating_button.dart'; // استدعاء الزر من الملف الجديد

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CustomFloatingButton(),
      body: const NotesViewBody(),
    );
  }
}
