import 'package:flutter/material.dart';
import 'package:notebook_app/screens/liste_notes_screen.dart'; // Import the new screen
import 'package:notebook_app/models/note.dart'; // Import the Note model
import 'package:notebook_app/screens/liste_notes_screen.dart';
import 'package:notebook_app/providers/note_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenue dans NoteBook App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bienvenue dans NoteBook App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Bienvenue dans NoteBook App",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListeNotesScreen()),
                );
              },
              child: const Text("Voir mes notes"),
            ),
          ],
        ),
      ),
    );
  }
}