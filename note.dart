class Note {
final String id;
final String title;
final String body;


const Note({required this.id, required this.title, required this.body});


Note copyWith({String? title, String? body}) => Note(
id: id,
title: title ?? this.title,
body: body ?? this.body,
);
}