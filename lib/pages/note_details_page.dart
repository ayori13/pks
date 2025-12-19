import 'package:flutter/material.dart';
import '../models/note.dart';
import '../data/notes_repository.dart';

class NoteDetailsPage extends StatelessWidget {
  final int id;
  final NotesRepository repo;

  const NoteDetailsPage({
    super.key,
    required this.id,
    required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Note>(
      future: repo.get(id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Ошибка')),
            body: Center(
              child: Text('Не удалось загрузить запись\n${snapshot.error}'),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Загрузка...')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final note = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text('Запись #${note.id}'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Аватар: обёртка с обработкой ошибки загрузки
                ClipOval(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: note.avatar.isNotEmpty
                        ? Image.network(
                            note.avatar,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person, size: 40);
                            },
                          )
                        : const Icon(Icons.person, size: 40),
                  ),
                ),
                const SizedBox(height: 16),

                // Имя
                Text(
                  note.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Дата создания
                Text(
                  'Создано: ${_formatDate(note.createdAt)}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(String isoString) {
    try {
      final dt = DateTime.parse(isoString);
      return '${dt.day}.${dt.month}.${dt.year} в ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return isoString;
    }
  }
}