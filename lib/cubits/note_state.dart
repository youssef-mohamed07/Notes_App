part of 'note_cubit.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteLoading extends NoteState {}

final class NoteLoaded extends NoteState {
  final List<NoteModel> notes;
  NoteLoaded(this.notes);
}

final class NoteAdded extends NoteState {
  final NoteModel note;
  NoteAdded(this.note);
}

final class NoteDeleted extends NoteState {
  final NoteModel note;
  NoteDeleted(this.note);
}

final class NoteUpdated extends NoteState {
  final NoteModel note;
  NoteUpdated(this.note);
}

final class NoteError extends NoteState {
  final String message;
  NoteError(this.message);
}
