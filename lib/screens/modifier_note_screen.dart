import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notebook_app/models/note.dart';
import 'package:notebook_app/providers/note_provider.dart'; // Adjust the import path if needed

class ModifierNoteScreen extends StatefulWidget {
  final int noteIndex;
  final Note note;

  const ModifierNoteScreen({super.key, required this.noteIndex, required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<ModifierNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the existing note's data
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final updatedTitle = _titleController.text;
    final updatedContent = _contentController.text;

    // Basic validation to ensure fields are not empty
    if (updatedTitle.isNotEmpty && updatedContent.isNotEmpty) {
      final updatedNote = Note(title: updatedTitle, content: updatedContent);

      // Access the NoteProvider and call the editNote method
      Provider.of<NoteProvider>(context, listen: false).editNote(widget.noteIndex, updatedNote);

      // Navigate back to the notes list after saving
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier la note"),
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
              onPressed: _saveChanges,
              child: const Text("Enregistrer les modifications"),
            ),
          ],
        ),
      ),
    );
  }
}