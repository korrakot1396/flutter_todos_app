class Todo {
  final String id;
  final String title;
  final String date;
  late final String status;
  final String description;
  final String? image;


  Todo({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    required this.description,
    required this.image,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
