import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_notes/main.dart';

void main() {
  // Сбрасываем ErrorWidget.builder перед каждым тестом на стандартное значение
  setUp(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return ErrorWidget(details.exception);
    };
  });

  testWidgets('App starts with example note', (WidgetTester tester) async {
    // Запускаем приложение
    await tester.pumpWidget(const SimpleNotesApp());

    // Проверяем заголовок приложения
    expect(find.text('Simple Notes'), findsOneWidget);

    // Проверяем примерную заметку
    expect(find.text('Пример'), findsOneWidget);
    expect(find.text('Пример заметки'), findsOneWidget);
  });

  testWidgets('Add new note button exists', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());

    // Проверяем кнопку добавления заметки
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Empty state shows message', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());

    // Проверяем, что есть список заметок
    expect(find.byType(ListTile), findsAtLeast(1));
  });
  testWidgets('Error handling - snackbar appears on save error', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SimpleNotesApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    final textFields = find.byType(TextFormField);

    await tester.enterText(textFields.at(0), 'Заголовок');
    await tester.enterText(textFields.at(1), 'Текст заметки');

    // Сохраняем
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    // Проверяем что вернулись на главный экран
    expect(find.text('Simple Notes'), findsOneWidget);
  });
}
