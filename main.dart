import 'package:flutter/material.dart';
import 'models/note.dart';
import 'edit_note_page.dart';

void main() => runApp(const SimpleNotesApp());

class SimpleNotesApp extends StatelessWidget {
  const SimpleNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Notes',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<Note> _notes = [
    const Note(id: '1', title: 'Пример', body: 'Это пример заметки.'),
  ];

  // Поиск
  final TextEditingController _searchCtrl = TextEditingController();
  bool _searchMode = false;

  List<Note> get _filteredNotes {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return _notes;
    return _notes.where((n) => n.title.toLowerCase().contains(q)).toList();
  }

  Future<void> _addNote() async {
    final newNote = await Navigator.push<Note>(
      context,
      MaterialPageRoute(builder: (_) => const EditNotePage()),
    );
    if (newNote != null) {
      setState(() => _notes.add(newNote));
    }
  }

  Future<void> _edit(Note note) async {
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
  }

  void _delete(Note note) {
    final removedIndex = _notes.indexWhere((n) => n.id == note.id);
    if (removedIndex == -1) return;

    final removed = _notes[removedIndex];
    setState(() => _notes.removeAt(removedIndex));

    // Undo через SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Заметка удалена'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () => setState(() => _notes.insert(removedIndex, removed)),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    if (_searchMode) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => setState(() {
            _searchMode = false;
            _searchCtrl.clear();
          }),
        ),
        title: TextField(
          controller: _searchCtrl,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Поиск по заголовку…',
            border: InputBorder.none,
          ),
          onChanged: (_) => setState(() {}),
        ),
      );
    }

    return AppBar(
      title: const Text('Simple Notes'),
      actions: [
        IconButton(
          tooltip: 'Поиск',
          icon: const Icon(Icons.search),
          onPressed: () => setState(() => _searchMode = true),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final notes = _filteredNotes;

    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
      body: notes.isEmpty
          ? const _EmptyState()
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              itemCount: notes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final note = notes[i];
                return Dismissible(
                  key: ValueKey(note.id),
                  background: _SwipeBg(alignment: Alignment.centerLeft),
                  secondaryBackground:
                      _SwipeBg(alignment: Alignment.centerRight),
                  onDismissed: (_) => _delete(note),
                  child: _NoteCard(
                    note: note,
                    onTap: () => _edit(note),
                    onDelete: () => _delete(note),
                  ),
                );
              },
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.note_alt_outlined, size: 64),
          const SizedBox(height: 12),
          Text(
            'Пока нет заметок. Нажмите +',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  const _NoteCard({required this.note, required this.onTap, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Text(
                  (note.title.trim().isEmpty ? '…' : note.title.trim()[0]).toUpperCase(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title.isEmpty ? '(без названия)' : note.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      note.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Удалить',
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SwipeBg extends StatelessWidget {
  final Alignment alignment;
  const _SwipeBg({required this.alignment});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.errorContainer,
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Icon(
        Icons.delete,
        color: Theme.of(context).colorScheme.onErrorContainer,
      ),
    );
  }
}