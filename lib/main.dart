import 'package:flutter/material.dart';
import 'package:notes_app/views/home_view.dart'; // ✅ Fixed double slashes

void main() {
  runApp(const NotesApp()); // ✅ Added `const` for optimization
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
      ),
      home: const HomeScreen(),
    );
  }
}
