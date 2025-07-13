class ChoreAssignment {
  final String chore;
  final String assignedTo;
  final int repeatDays;
  final DateTime nextDueDate;

  ChoreAssignment({
    required this.chore,
    required this.assignedTo,
    required this.repeatDays,
    required this.nextDueDate,
  });

  ChoreAssignment copyWith({
    String? chore,
    String? assignedTo,
    int? repeatDays,
    DateTime? nextDueDate,
  }) {
    return ChoreAssignment(
      chore: chore ?? this.chore,
      assignedTo: assignedTo ?? this.assignedTo,
      repeatDays: repeatDays ?? this.repeatDays,
      nextDueDate: nextDueDate ?? this.nextDueDate,
    );
  }
}
