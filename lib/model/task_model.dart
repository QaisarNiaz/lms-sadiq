class TaskModel {
  final String id;
  final String subjectName;
  final String title;
  final String description;
  final DateTime dueDate;
  final String? documentUrl;
  String status; // 'Pending' or 'Submitted'

  TaskModel({
    required this.id,
    required this.subjectName,
    required this.title,
    required this.description,
    required this.dueDate,
    this.documentUrl,
    this.status = 'Pending',
  });
}
