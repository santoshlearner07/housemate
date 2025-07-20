import 'package:flutter/material.dart';
import 'chore_assignment.dart';

class AdminScreen extends StatefulWidget {
  final List<String> roommates;
  final List<String> chores;

  const AdminScreen({Key? key, required this.roommates, required this.chores}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late List<String> roommates;
  late List<String> chores;
  final List<ChoreAssignment> assignments = [];
  final Map<String, List<DateTime>> assignmentHistory = {};

  String selectedChore = '';
  String selectedRoommate = '';
  int repeatDays = 7;

  @override
  void initState() {
    super.initState();
    roommates = widget.roommates;
    chores = widget.chores;

    if (roommates.isNotEmpty) selectedRoommate = roommates.first;
    if (chores.isNotEmpty) selectedChore = chores.first;

    for (var name in roommates) {
      assignmentHistory[name] = [];
    }
  }

  void assignChore() {
    final today = DateTime.now();

    // Prevent assigning the same person the same task for today
    if (assignmentHistory[selectedRoommate]?.any((d) =>
        d.day == today.day && d.month == today.month && d.year == today.year) ??
        false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$selectedRoommate already has this task today!"),
      ));
      return;
    }

    final assignment = ChoreAssignment(
      chore: selectedChore,
      repeatDays: repeatDays,
      nextDueDate: today,
      rotationList: roommates,
    );

    assignmentHistory[selectedRoommate]?.add(today);

    setState(() {
      assignments.add(assignment);
    });
  }

  void updateAssignments() {
    setState(() {
      for (var assignment in assignments) {
        assignment.updateNextAssignee();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Assignment Panel')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedChore,
              items: chores.map((chore) => DropdownMenuItem(
                value: chore,
                child: Text(chore),
              )).toList(),
              onChanged: (val) => setState(() => selectedChore = val!),
            ),
            DropdownButton<String>(
              value: selectedRoommate,
              items: roommates.map((person) => DropdownMenuItem(
                value: person,
                child: Text(person),
              )).toList(),
              onChanged: (val) => setState(() => selectedRoommate = val!),
            ),
            DropdownButton<int>(
              value: repeatDays,
              items: [7, 10, 15].map((days) => DropdownMenuItem(
                value: days,
                child: Text('$days Days'),
              )).toList(),
              onChanged: (val) => setState(() => repeatDays = val!),
            ),
            ElevatedButton(
              onPressed: assignChore,
              child: const Text('Assign Chore'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateAssignments,
              child: const Text('Simulate Rotation'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: assignments.length,
                itemBuilder: (context, index) {
                  final a = assignments[index];
                  return ListTile(
                    title: Text('${a.chore}'),
                    subtitle: Text('Assigned to: ${a.assignedTo} | Next due: ${a.nextDueDate.toLocal()}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
