import 'package:flutter/material.dart';
import 'models/note.dart';
import 'edit_note_page.dart';
import 'dart:async';

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    print('Flutter Error: ${details.exception}');
    print('Stack trace: ${details.stack}');
  };

  runZonedGuarded(
    () {
      runApp(const SimpleNotesApp());
    },
    (error, stackTrace) {
      print('Uncaught Error: $error');
      print('Stack trace: $stackTrace');
    },
  );
}

class SimpleNotesApp extends StatelessWidget {
  const SimpleNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Notes',
      theme: ThemeData(useMaterial3: true),
      home: const NotesPage(),
      builder: (context, child) {
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 20),
                Text(
                  'Что-то пошло не так',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  'Приложение столкнулось с ошибкой',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const NotesPage()),
                      (route) => false,
                    );
                  },
                  child: const Text('Вернуться к заметкам'),
                ),
              ],
            ),
          );
        };
        return child!;
      },
    );
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NoteListItem extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _NoteListItem({
    required this.note,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(note.id),
      title: Text(
        note.title.isEmpty ? '(без названия)' : note.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(note.body, maxLines: 1, overflow: TextOverflow.ellipsis),
      onTap: onTap,
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: onDelete,
      ),
    );
  }
}

class _NotesPageState extends State<NotesPage> {
  final List<Note> _notes = [
    Note(id: '1', title: 'Пример', body: 'Пример заметки'),
  ];

  Future<void> _addNote() async {
    try {
      final newNote = await Navigator.push<Note>(
        context,
        MaterialPageRoute(builder: (_) => const EditNotePage()),
      );

      if (newNote != null) {
        setState(() => _notes.add(newNote));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка при добавлении заметки: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _edit(Note note) async {
    try {
      final updated = await Navigator.push<Note>(
        context,
        MaterialPageRoute(builder: (_) => EditNotePage(existing: note)),
      );

      if (updated != null) {
        setState(() {
          final i = _notes.indexWhere((n) => n.id == updated.id);
          if (i != -1) _notes[i] = updated;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка при редактировании: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _delete(Note note) {
    try {
      setState(() => _notes.removeWhere((n) => n.id == note.id));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Заметка удалена'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка при удалении: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
      body: _notes.isEmpty
          ? const Center(
              child: Text(
                'Пока нет заметок. Нажмите +',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              // ← ИЗМЕНЕНО: обратно на builder
              itemCount: _notes.length,
              itemBuilder: (context, i) {
                final note = _notes[i];
                return Dismissible(
                  key: ValueKey(note.id),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    final result = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Удалить заметку?'),
                        content: const Text(
                          'Заметка будет удалена безвозвратно.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Отмена'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Удалить'),
                          ),
                        ],
                      ),
                    );
                    return result ?? false;
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) => _delete(note),
                  child: _NoteListItem(
                    note: note,
                    onTap: () => _edit(note),
                    onDelete: () {
                      showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Удалить заметку?'),
                          content: const Text(
                            'Заметка будет удалена безвозвратно.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _delete(note);
                              },
                              child: const Text('Удалить'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
