import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notebook_app/models/note.dart';
import 'package:notebook_app/providers/note_provider.dart';

class AjouterNoteScreen extends StatefulWidget {
  const AjouterNoteScreen({super.key});

  @override
  _AjouterNoteScreenState createState() => _AjouterNoteScreenState();
}

class _AjouterNoteScreenState extends State<AjouterNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text;
    final content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      final newNote = Note(title: title, content: content);
      // Access the NoteProvider and add the new note
      Provider.of<NoteProvider>(context, listen: false).addNote(newNote);
      Navigator.pop(context); // Go back to the notes list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter une note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Titre"),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: "Contenu"),
              maxLines: null, // Allow multiple lines for content
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveNote,
              child: const Text("Enregistrer"),
            ),
          ],
        ),
      ),
    );
  }
}