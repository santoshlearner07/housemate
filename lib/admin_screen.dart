import 'package:flutter/material.dart';
import 'chore_assignment.dart';

class RotatingChore {
  final String choreName;
  final List<String> assignedRoommates;
  final int repeatDays;
  final DateTime startDate;

  RotatingChore({
    required this.choreName,
    required this.assignedRoommates,
    required this.repeatDays,
    required this.startDate,
  });

  List<ChoreInstance> generateSchedule(int numberOfCycles) {
    List<ChoreInstance> schedule = [];
    for (int i = 0; i < numberOfCycles; i++) {
      final person = assignedRoommates[i % assignedRoommates.length];
      final dueDate = startDate.add(Duration(days: i * repeatDays));
      schedule.add(ChoreInstance(person, choreName, dueDate));
    }
    return schedule;
  }
}

class ChoreInstance {
  final String person;
  final String chore;
  final DateTime dueDate;

  ChoreInstance(this.person, this.chore, this.dueDate);
}

class AdminScreen extends StatefulWidget {
  final List<String> roommates;
  final List<String> chores;

  const AdminScreen({super.key, required this.roommates, required this.chores});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String? selectedRoommate;
  String? selectedChore;
  int selectedRepeatDays = 7;

  List<ChoreAssignment> assignments = [];

  void assignChore() {
    if (selectedChore != null && selectedRoommate != null) {
      final assignment = ChoreAssignment(
        chore: selectedChore!,
        assignedTo: selectedRoommate!,
        repeatDays: selectedRepeatDays,
        nextDueDate: DateTime.now().add(Duration(days: selectedRepeatDays)),
      );

      setState(() {
        assignments.add(assignment);
      });
    }
  }

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text("Select Roommate"),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedRoommate,
              hint: const Text("Choose roommate"),
              onChanged: (value) => setState(() => selectedRoommate = value),
              items: widget.roommates
                  .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                  .toList(),
            ),
            const SizedBox(height: 12),

            const Text("Select Chore"),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedChore,
              hint: const Text("Choose chore"),
              onChanged: (value) => setState(() => selectedChore = value),
              items: widget.chores
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
            ),
            const SizedBox(height: 12),

            const Text("Repeat every..."),
            DropdownButton<int>(
              value: selectedRepeatDays,
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedRepeatDays = value);
                }
              },
              items: const [
                DropdownMenuItem(value: 7, child: Text("7 Days")),
                DropdownMenuItem(value: 10, child: Text("10 Days")),
                DropdownMenuItem(value: 15, child: Text("15 Days")),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: assignChore,
              child: const Text("Assign Chore"),
            ),
            const Divider(height: 30),
            const Text("Assigned Chores", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...assignments.map(
              (assignment) => ListTile(
                title: Text("${assignment.chore} ➜ ${assignment.assignedTo}"),
                subtitle: Text("Repeat every ${assignment.repeatDays} days\nNext due: ${formatDate(assignment.nextDueDate)}"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
