import 'package:flutter/material.dart';
// import 'utils/assignment_helper.dart';

class HomeScreen extends StatelessWidget {
  final List<String> roommates;
  final List<String> chores = [
    'Clean Kitchen',
    'Take Out Trash',
    'Clean Bathroom',
    'Vacuum Whole house',
  ];

  HomeScreen({super.key, required this.roommates});

  final DateTime startDate = DateTime(2024, 7, 1); // Your chosen start date

  @override
  Widget build(BuildContext context) {
    final assignments = assignChores(
      chores: chores,
      roommates: roommates,
      startDate: startDate,
    );

    // Show popup only once after build, only on Mondays
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final today = DateTime.now();
      if (today.weekday == DateTime.tuesday) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Weekly Chores Assigned!"),
            content: const Text("Check your assigned task below for this week."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Weekly Chore Rotation")),
      body: ListView.builder(
        itemCount: assignments.length,
        itemBuilder: (context, index) {
          final assignment = assignments[index];
          return Card(
            child: ListTile(
              title: Text('${assignment['chore']}'),
              subtitle: Text('Assigned to: ${assignment['assignedTo']}'),
            ),
          );
        },
      ),
    );
  }
}
