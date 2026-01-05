class FeeModel {
  final String month;
  final int amount;
  final String dueDate;
  bool isPaid;

  FeeModel({
    required this.month,
    required this.amount,
    required this.dueDate,
    required this.isPaid,
  });
}

class CalendarEvent {
  final DateTime date;
  final String title;

  CalendarEvent({required this.date, required this.title});
}
