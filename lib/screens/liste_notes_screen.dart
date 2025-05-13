import 'package:flutter/material.dart';
import 'package:notebook_app/screens/ajouter_note_screen.dart';
import 'package:notebook_app/screens/modifier_note_screen.dart';
import 'package:provider/provider.dart';
import 'package:notebook_app/models/note.dart';
import 'package:notebook_app/providers/note_provider.dart';
import 'package:notebook_app/screens/ajouter_note_screen.dart';
import 'package:notebook_app/screens/modifier_note_screen.dart'; // Import the edit screen

class ListeNotesScreen extends StatelessWidget {
  const ListeNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final notes = noteProvider.notes;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes notes"),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(note.content),
              // Add the onTap callback
              onTap: () {
                // Navigate to the EditNoteScreen when the list tile is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModifierNoteScreen(
                      noteIndex: index, // Pass the index of the note
                      note: note,       // Pass the note data
                    ),
                  ),
                );
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  Provider.of<NoteProvider>(context, listen: false).removeNote(index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AjouterNoteScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}