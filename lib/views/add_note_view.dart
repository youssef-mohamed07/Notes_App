import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/widgets/add_note_form.dart'; // NEW: Import the new widget file

class AddNoteView extends StatefulWidget {
  AddNoteView({super.key});

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery
            .of(context)
            .viewInsets
            .bottom + 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: BlocConsumer<AddNoteCubit, AddNoteState>(
          listener: (context, state) {
            if(state is AddNoteSuccess){
              Navigator.pop(context);
            }
            if(state is AddNoteFailure){
              print('Failed ${state.errMessage}');

            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall:state is AddNoteLoading ?true :false ,

                child: AddNoteForm());
          },
        ), // Use extracted widget here
      ),
    );
  }
}
