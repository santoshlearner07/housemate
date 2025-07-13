List<Map<String, String>> assignChores({
  required List<String> chores,
  required List<String> roommates,
  required DateTime startDate,
}) {
  final now = DateTime.now();
  final weekNumber = now.difference(startDate).inDays ~/ 7;

  List<Map<String, String>> assignments = [];

  for (int i = 0; i < chores.length; i++) {
    final assigneeIndex = (i + weekNumber) % roommates.length;
    assignments.add({
      'chore': chores[i],
      'assignedTo': roommates[assigneeIndex],
    });
  }

  return assignments;
}
