class Note {
  final int id;
  final String name;
  final String avatar;
  final String createdAt;

  Note({
    required this.id,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] is String ? int.tryParse(json['id']) ?? 0 : (json['id'] ?? 0),
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(), // mockapi.io ожидает id как строку
      'name': name,
      'avatar': avatar,
      'createdAt': createdAt,
    };
  }
}