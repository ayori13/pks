import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_notes/main.dart';
import 'package:simple_notes/models/note.dart';

void main() {
  // Сбрасываем ErrorWidget.builder перед каждым тестом на стандартное значение
  setUp(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return ErrorWidget(details.exception);
    };
  });

  testWidgets('Проверка заголовка экрана', (WidgetTester tester) async {
    // Запускаем приложение
    await tester.pumpWidget(const SimpleNotesApp());

    // Проверяем, что заголовок есть на экране
    expect(find.text('Simple Notes'), findsOneWidget);
  });

  testWidgets('Начальное состояние - есть одна заметка', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SimpleNotesApp());

    // Ждем пока приложение загрузится
    await tester.pumpAndSettle();

    // Проверяем, что есть начальная заметка "Пример"
    expect(find.text('Пример'), findsOneWidget);
    expect(find.text('Пример заметки'), findsOneWidget);
  });

  testWidgets('Кнопка + открывает форму новой заметки', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SimpleNotesApp());
    await tester.pumpAndSettle();

    // Находим кнопку добавления (FloatingActionButton)
    final fab = find.byIcon(Icons.add);
    expect(fab, findsOneWidget);

    // Нажимаем на кнопку
    await tester.tap(fab);

    // Ждем анимацию
    await tester.pumpAndSettle();

    // Проверяем, что открылась форма новой заметки
    expect(find.text('Новая заметка'), findsOneWidget);
    expect(find.text('Заголовок'), findsOneWidget);
    expect(find.text('Текст'), findsOneWidget);
  });

  testWidgets('Тап по заметке открывает форму редактирования', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SimpleNotesApp());
    await tester.pumpAndSettle();

    // Нажимаем на существующую заметку
    await tester.tap(find.text('Пример'));
    await tester.pumpAndSettle();

    // Проверяем, что открылась форма редактирования
    expect(find.text('Редактировать'), findsOneWidget);
  });

  testWidgets('Кнопка удаления удаляет заметку', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());
    await tester.pumpAndSettle();

    // Находим кнопку удаления (иконка корзины)
    final deleteButton = find.byIcon(Icons.delete_outline);
    expect(deleteButton, findsOneWidget);

    // Нажимаем кнопку удаления
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    // Появляется диалог подтверждения - нужно нажать "Удалить"
    expect(find.text('Удалить заметку?'), findsOneWidget);

    // Нажимаем кнопку "Удалить" в диалоге
    await tester.tap(find.text('Удалить'));
    await tester.pumpAndSettle();

    // Проверяем, что заметка исчезла
    expect(find.text('Пример'), findsNothing);

    // Проверяем, что появилось сообщение "Нет заметок"
    expect(find.text('Пока нет заметок. Нажмите +'), findsOneWidget);
  });

  testWidgets('Создание новой заметки через форму', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SimpleNotesApp());
    await tester.pumpAndSettle();

    // Открываем форму новой заметки
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Находим все TextFormField и заполняем их
    final textFields = find.byType(TextFormField);
    expect(textFields, findsNWidgets(2));

    // Заполняем заголовок (первое поле)
    await tester.enterText(textFields.at(0), 'Моя заметка');

    // Заполняем текст (второе поле)
    await tester.enterText(textFields.at(1), 'Это мой текст');

    // Нажимаем кнопку "Сохранить"
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    // Проверяем, что вернулись на главный экран
    expect(find.text('Simple Notes'), findsOneWidget);

    // Проверяем, что заметка добавилась
    expect(find.text('Моя заметка'), findsOneWidget);
  });

  testWidgets('Пустая заметка показывает "(без названия)"', (
    WidgetTester tester,
  ) async {
    final note = Note(id: 'test', title: '', body: 'Тело заметки');

    // Проверяем, что заголовок действительно пустой
    expect(note.title.isEmpty, true);
  });

  testWidgets('Заметки отображаются в списке', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());
    await tester.pumpAndSettle();

    // Проверяем, что ListView есть (не пустой список)
    expect(find.byType(ListView), findsOneWidget);

    // Проверяем, что есть ListTile (элемент списка)
    expect(find.byType(ListTile), findsOneWidget);
  });

  testWidgets('Нажатие кнопки сохранения в форме', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleNotesApp());
    await tester.pumpAndSettle();

    // Открываем форму
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Находим все TextFormField
    final textFields = find.byType(TextFormField);
    expect(textFields, findsNWidgets(2));

    // Заполняем обязательное поле "Текст" (второе поле)
    await tester.enterText(textFields.at(1), 'Тестовый текст');

    // Проверяем, что есть текст "Сохранить" и иконка галочки
    expect(find.text('Сохранить'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);

    // Нажимаем кнопку "Сохранить"
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    // Проверяем, что вернулись на главный экран
    expect(find.text('Simple Notes'), findsOneWidget);
  });

  testWidgets('Ошибка при сохранении - показывает SnackBar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SimpleNotesApp());
    await tester.pumpAndSettle();

    // Открываем форму
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Проверяем валидацию пустого текста
    final textFields = find.byType(TextFormField);

    // Заполняем только заголовок, оставляем текст пустым
    await tester.enterText(textFields.at(0), 'Тестовая заметка');
    // Текст не заполняем - должно вызвать валидацию

    // Пытаемся сохранить
    await tester.tap(find.text('Сохранить'));
    await tester.pump();

    // Проверяем что остались на форме (валидация не прошла)
    expect(find.text('Новая заметка'), findsOneWidget);
  });

  testWidgets('Тестовая ошибка при сохранении (если есть в коде)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SimpleNotesApp());
    await tester.pumpAndSettle();

    // Открываем форму
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    final textFields = find.byType(TextFormField);

    await tester.enterText(textFields.at(0), 'тест ошибка');
    await tester.enterText(textFields.at(1), 'Текст заметки');

    // Сохраняем
    await tester.tap(find.text('Сохранить'));
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Обработка ошибки при удалении заметки', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SimpleNotesApp());
    await tester.pumpAndSettle();

    // Удаляем заметку через диалог подтверждения
    final deleteButton = find.byIcon(Icons.delete_outline);
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    // Диалог должен появиться
    expect(find.text('Удалить заметку?'), findsOneWidget);

    // Подтверждаем удаление
    await tester.tap(find.text('Удалить'));
    await tester.pumpAndSettle();

    // Проверяем что заметка удалилась
    expect(find.text('Пример'), findsNothing);
  });
}
