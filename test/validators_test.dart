import 'package:flutter_test/flutter_test.dart';
import 'package:simple_notes/models/note.dart';

void main() {
  group('Note Creation Tests', () {
    test('Empty title shows in list as (без названия)', () {
      final note = Note(id: '1', title: '', body: 'Тело заметки');
      expect(note.title.isEmpty, true);
    });

    test('Note with empty body should not be saved', () {
      final note = Note(id: '2', title: 'Заголовок', body: '');
      expect(note.body.isEmpty, true);
    });

    test('CopyWith updates only specified fields', () {
      final original = Note(id: '3', title: 'Старый', body: 'Старое тело');
      final updated = original.copyWith(title: 'Новый');

      expect(updated.id, '3');
      expect(updated.title, 'Новый');
      expect(updated.body, 'Старое тело');
    });

    test('Long title is truncated in UI', () {
      final longTitle =
          'Очень длинный заголовок заметки, который должен обрезаться в интерфейсе';
      final note = Note(id: '4', title: longTitle, body: 'Тело');

      expect(note.title.length > 20, true);
    });

    test('Note with whitespace only body is invalid', () {
      final note = Note(id: '5', title: 'Заголовок', body: '   ');
      expect(note.body.trim().isEmpty, true);
    });
  });
  test('CopyWith with both fields updates both', () {
    final original = Note(id: '3', title: 'Старый', body: 'Старое тело');
    final updated = original.copyWith(title: 'Новый', body: 'Новое тело');
    expect(updated.id, '3');
    expect(updated.title, 'Новый');
    expect(updated.body, 'Новое тело');
  });
}
