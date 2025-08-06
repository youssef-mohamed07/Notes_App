import 'package:flutter/material.dart';
import 'package:notes_app/widgets/notes_item.dart';

class NotesListView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context,index){
      return const NotesItem();
    });
  }
}
