import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notebook_app/models/note.dart';
import 'package:notebook_app/providers/note_provider.dart';

class ModifierNoteScreen extends StatefulWidget {
  final int noteIndex;
  final Note note;

  const ModifierNoteScreen({
    super.key,
    required this.noteIndex,
    required this.note,
  });

  @override
  State<ModifierNoteScreen> createState() => _ModifierNoteScreenState();
}

class _ModifierNoteScreenState extends State<ModifierNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final updatedTitle = _titleController.text.trim();
    final updatedContent = _contentController.text.trim();

    if (updatedTitle.isEmpty || updatedContent.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Titre et contenu sont requis.")),
      );
      return;
    }

    final updatedNote = Note(title: updatedTitle, content: updatedContent);

    Provider.of<NoteProvider>(context, listen: false)
        .editNote(widget.noteIndex, updatedNote);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
        title: Text(
          "📝 Modifier la note",
          style: TextStyle(color: colorScheme.onPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Rafraîchis ta pensée ✨",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Titre",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.title),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: "Contenu",
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.edit_note),
              ),
              maxLines: 10,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _saveChanges,
              icon: const Icon(Icons.save),
              label: const Text("Enregistrer les modifications"),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
