# Практическое занятие №5 Работа со списками. Передача данных между модулями

## Джанкезов Руслан ЭФБО-09-23 

### Цели ПЗ
- Отобразить коллекцию заметок с помощью списка (ListView).

- Реализовать добавление, редактирование и удаление элементов без внешних пакетов.

- Освоить работу с навигацией Navigator.push / Navigator.pop и передачей данных.

- Сделать поиск по заголовку в AppBar и свайп-удаление (Dismissible).

### Ход работы

1. Создан проект Flutter simple_notes.

2. Определена модель данных Note (id, title, body) с методом copyWith()
   
3. Главный экран (main.dart): список заметок отображается через ListView.separated; при пустом списке выводится сообщение «Пока нет заметок. Нажмите +»

4. Экран редактирования/создания (edit_note_page.dart): форма с полями для заголовка и текста заметки, валидация и сохранение через Navigator.pop(context, note)

5. Добавлена возможность поиска по заголовку заметки в AppBar

6. Реализовано удаление заметки двумя способами: кнопкой корзины и свайп-удалением (Dismissible) с SnackBar и Undo

#### Фрагменты кода:
Пустой список по умолчанию:
```
final List<Note> _notes = [];
```
Навигация с возвратом результата:
```
final newNote = await Navigator.push<Note>(
  context,
  MaterialPageRoute(builder: (_) => const EditNotePage()),
);
Navigator.pop(context, updatedNote);
```

Ключи для корректных анимаций в списке:
```
key: ValueKey(note.id),
```

Свайп-удаление:
```
Dismissible(
  key: ValueKey(note.id),
  onDismissed: (_) => _delete(note),
  child: ...
)
```

Поиск:
```
onChanged: (_) => setState(() {});
```
### Скриншоты
1. В начале нас встречает пример заметки, которую можно удалить 
<img width="669" height="990" alt="image" src="https://github.com/user-attachments/assets/e9b67783-2c20-43ba-9c6c-1d4e23d3b986" />
<img width="672" height="980" alt="image" src="https://github.com/user-attachments/assets/126498b6-6ac9-4b5f-a132-9525f02dd6e7" />
2. Мы можем создать свою заметку нажам на значок "+" на начальном экране
<img width="677" height="965" alt="image" src="https://github.com/user-attachments/assets/51b09fd7-7182-407b-887f-15abe1eaa191" />
3. Список заметок
<img width="663" height="994" alt="image" src="https://github.com/user-attachments/assets/9324a50f-9509-41da-9cbb-ca936fc32be4" />
4. Редактировать заметку можно по простомцу нажатию на нее
<img width="673" height="993" alt="image" src="https://github.com/user-attachments/assets/e06acac7-5a71-40d6-b290-8077550d65f7" />
<img width="673" height="994" alt="image" src="https://github.com/user-attachments/assets/97404137-77f9-4180-a881-fb9559d366f7" />
<img width="666" height="975" alt="image" src="https://github.com/user-attachments/assets/3a21f64b-3eb2-4540-bf85-303e967a2470" />
5. После удаления(на кнопку корзины) высвечивается Снекбар с надписью "Заметка удалена"
<img width="675" height="987" alt="image" src="https://github.com/user-attachments/assets/b05acdae-c4f0-4e05-82d6-799c458c29ec" />
6. Режим поиска с фильтрацией по заголовку
<img width="669" height="975" alt="image" src="https://github.com/user-attachments/assets/4db739ed-865e-4a4d-975d-b4c1644fd588" />


### Вывод

- Удалось реализовать список заметок с добавлением, редактированием, удалением, поиском и свайп-удалением.

- Наиболее сложным оказалось правильно организовать возврат результата из экрана редактирования и работу с Dismissible (состояние и Undo).

- В дальнейшем приложение можно улучшить за счёт сохранения заметок в SharedPreferences или базе данных, добавления анимаций (AnimatedList), создания темной темы и пагинации.
