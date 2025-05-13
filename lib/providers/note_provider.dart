import 'package:flutter/foundation.dart';
import 'package:notebook_app/models/note.dart';

class NoteProvider extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => List.unmodifiable(_notes);

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void removeNote(int index) {
    if (index >= 0 && index < _notes.length) {
      _notes.removeAt(index);
      notifyListeners();
    }
  }

  // Method to edit a note by index
  void editNote(int index, Note updatedNote) {
    if (index >= 0 && index < _notes.length) {
      _notes[index] = updatedNote;
      notifyListeners();
    }
  }
}