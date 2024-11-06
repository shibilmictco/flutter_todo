class TodoModel {
  final String title;
  final String decription;
  final bool isCompleted;

  const TodoModel({
    required this.title,
    required this.decription,
    this.isCompleted = false,
  });
}
