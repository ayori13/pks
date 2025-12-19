# Практическое занятие № 9 Работа с базами данных. Подключение приложения к Supabase (Flutter).
# ЭФБО-09-23 Доронина Мария

# Цели:
Подключить Flutter-приложение к Supabase (Postgres + Auth + Realtime).

Освоить инициализацию supabase_flutter, чтение/запись данных и потоковые обновления (stream()).

Реализовать базовый CRUD (создание, чтение, обновление, удаление) с реактивным списком.

Включить Row Level Security (RLS) и настроить безопасные политики доступа для аутентифицированных пользователей.

# Ход работы:
1. Скриншот настроенного проекта Supabase (Dashboard: Database → notes, включён RLS, список Policies).
<img width="1316" height="579" alt="image" src="https://github.com/user-attachments/assets/908afc8d-9fc2-4ab8-ab30-6c6aaffa73ca" />
<img width="1192" height="595" alt="image" src="https://github.com/user-attachments/assets/0cab5805-42a8-4aa2-901e-67505ad0aa06" />

2. Скриншот экрана входа и экрана со списком (пустого и с данными).
<img width="304" height="577" alt="image" src="https://github.com/user-attachments/assets/890c0fec-9549-410c-9669-3855ceab8bd5" />
<img width="295" height="604" alt="image" src="https://github.com/user-attachments/assets/9b6ae121-d79e-465b-883f-ad6e783afb7b" />

3. Скриншот после добавления заметки (элемент появился).
<img width="288" height="609" alt="image" src="https://github.com/user-attachments/assets/b806b9f1-7704-425b-8965-a6d53309293b" />

4. Скриншот после редактирования и после удаления.
<img width="296" height="614" alt="image" src="https://github.com/user-attachments/assets/998aeb8f-32d9-4ad5-93e1-7b243c8d62ae" />
<img width="295" height="604" alt="image" src="https://github.com/user-attachments/assets/e480f7de-a6b8-4485-bed5-3753b9c3c313" />

# Подключение Supabase
Создан проект в Supabase и сгенерированы Project URL и anon key.

Был подключен пакет и инициализирован Supabase во Flutter до запуска приложения.

Приватные ключи и секреты не публиковались.

Проверка, что приложение запускается без ошибок.

# Зависимости и инициализация
Использован пакет supabase_flutter (v2).

Подключение и инициализация выполнены в main.dart.

В проекте реализованы экраны аутентификации и заметок (AuthGate и NotesPage).

# Структура таблицы

Таблица notes содержит поля: id, user_id, title, content, created_at, updated_at. 

Тип базы данных — PostgreSQL. 

Включен Row Level Security (RLS).

# Политики безопасности (RLS)
Чтение только своих записей.

Вставка только от имени текущего пользователя.

Обновление и удаление только своих записей.

Все политики действуют для регистрированных пользователей.
















