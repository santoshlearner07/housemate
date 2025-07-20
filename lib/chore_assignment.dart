import 'package:flutter/material.dart';

class ChoreAssignment {
  final String chore;
  final List<String> rotationList;
  int currentIndex;
  final int repeatDays;
  DateTime nextDueDate;

  ChoreAssignment({
    required this.chore,
    required this.rotationList,
    this.currentIndex = 0,
    required this.repeatDays,
    required this.nextDueDate,
  });

  String get assignedTo => rotationList[currentIndex];

  void updateNextAssignee() {
    currentIndex = (currentIndex + 1) % rotationList.length;
    nextDueDate = nextDueDate.add(Duration(days: repeatDays));
  }

  bool isSamePersonAssigned(DateTime date) {
    return nextDueDate == date;
  }
}
