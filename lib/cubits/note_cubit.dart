import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note_model.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial()) {
    fetchNotes();
  }

  List<NoteModel> notes = [];

  Future<Box<NoteModel>> _openBox() async {
    if (!Hive.isBoxOpen(kNoteBox)) {
      await Hive.openBox<NoteModel>(kNoteBox);
    }
    return Hive.box<NoteModel>(kNoteBox);
  }

  Future<void> fetchNotes() async {
    try {
      emit(NoteLoading());
      final box = await _openBox();
      notes = box.values.toList();

      notes.sort((a, b) {
        try {
          return DateTime.parse(b.date).compareTo(DateTime.parse(a.date));
        } catch (_) {
          return b.date.compareTo(a.date);
        }
      });

      emit(NoteLoaded(List.unmodifiable(notes)));
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> addNote(NoteModel note) async {
    try {
      final box = await _openBox();
      await box.add(note);
      await fetchNotes();
      emit(NoteAdded(note));
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> deleteNote(NoteModel note) async {
    try {
      await note.delete();
      await fetchNotes();
      emit(NoteDeleted(note));
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> deleteByKey(int key) async {
    try {
      final box = await _openBox();
      final note = box.get(key);
      if (note != null) {
        await box.delete(key);
        await fetchNotes();
        emit(NoteDeleted(note));
      }
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> updateNote(
      NoteModel note, {
        String? title,
        String? subTitle,
        int? color,
        bool updateDate = true,
      }) async {
    try {
      if (title != null) note.title = title;
      if (subTitle != null) note.subTitle = subTitle;
      if (color != null) note.color = color;
      if (updateDate) note.date = DateTime.now().toIso8601String();

      await note.save();
      await fetchNotes();
      emit(NoteUpdated(note));
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> replaceNoteAtKey(int key, NoteModel newNote) async {
    try {
      final box = await _openBox();
      await box.put(key, newNote);
      await fetchNotes();
      emit(NoteUpdated(newNote));
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }
}
