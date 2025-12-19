# Практическое занятие №12 Аппаратная часть мобильных устройств. Работа с камерой устройства.
# ЭФБО-09-23 Джанкёзов Руслан

# Цели: 

- Изучить архитектуру и возможности аппаратной части мобильных устройств.
- Ознакомиться с API камеры и галереи во Flutter.
- Научиться создавать приложения, использующие камеру и хранилище устройства.
-Разобраться с разрешениями, обработкой изображений и сохранением данных.

# Ход работы:

## Настройка платформы Android

Для работы с медиафайлами я настроил необходимые разрешения в файле `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

## Функциональность приложения

Я разработал одностраничное приложение, которое предоставляет пользователю следующие возможности:

1. **Съёмка фотографий** — использование камеры устройства для создания новых снимков
2. **Выбор изображений** — загрузка существующих фото из галереи устройства
3. **Просмотр изображений** — отображение выбранных или снятых фото в интерфейсе приложения
4. **Обработка изображений** — применение черно-белого фильтра к загруженным изображениям
5. **Сохранение результатов** — запись обработанных фото в локальное хранилище приложения

## Реализация ключевых функций

### Запрос разрешений
Для корректной работы с медиафайлами на разных платформах я реализовал систему запроса разрешений:
```dart
if (Platform.isAndroid) {
  await Permission.storage.request();
} else if (Platform.isIOS) {
  await Permission.photos.request();
}
```

### Работа с изображениями
Выбор источника изображения (камера или галерея) и обработка результата:
```dart
final XFile? pickedFile = await picker.pickImage(source: source);
if (pickedFile != null) {
  setState(() => _image = File(pickedFile.path));
}
```

### Сохранение файлов
Для сохранения обработанных изображений я использовал механизм работы с файловой системой:
```dart
final dir = await getApplicationDocumentsDirectory();
final newFile = await _image!.copy('${dir.path}/photo_${DateTime.now().millisecondsSinceEpoch}.jpg');
```

## Демонстрация работы приложения

### 1. Главный экран
Интерфейс приложения с кнопками для выбора источника изображения


<img width="370" height="664" alt="image" src="https://github.com/user-attachments/assets/3a0d45d3-4004-4953-9dd1-44dbcfd7a3d2" />


### 2. Работа с камерой
Процесс съёмки фото через встроенный интерфейс камеры устройства


<img width="374" height="567" alt="image" src="https://github.com/user-attachments/assets/241096d1-97b6-412b-a344-08bc5a505e25" />


### 3. Просмотр изображения и сохранение
Отображение выбранного или снятого фото и уведомление об успешном сохранении обработанного изображения
<img width="374" height="567" alt="image" src="https://github.com/user-attachments/assets/42989fe4-d1a6-4a4c-8f42-820e3ab274db" />

<img width="374" height="567" alt="image" src="https://github.com/user-attachments/assets/fb27999c-46b2-47b8-afb5-ae890571ca15" />

