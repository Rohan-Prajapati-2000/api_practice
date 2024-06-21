class JsonModelClass {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  JsonModelClass(
      {required this.userId,
        required this.id,
        required this.title,
        required this.completed});

  factory JsonModelClass.fromJson(Map<dynamic, dynamic> json) {
    return JsonModelClass(
        userId: json['userId'] ?? 0,
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        completed: json['completed'] ?? false);
  }
}