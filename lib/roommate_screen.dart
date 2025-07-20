import 'package:flutter/material.dart';

class RoommateScreen extends StatelessWidget {
  const RoommateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real chore assignments later
    final List<Map<String, dynamic>> dummyChores = [
      {"chore": "Clean Kitchen", "dueDate": "2025-07-25"},
      {"chore": "Mop Floor", "dueDate": "2025-07-28"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("My Chores")),
      body: ListView.builder(
        itemCount: dummyChores.length,
        itemBuilder: (context, index) {
          final chore = dummyChores[index];
          return ListTile(
            title: Text(chore['chore']),
            subtitle: Text("Due on: ${chore['dueDate']}"),
            leading: const Icon(Icons.task_alt_outlined),
          );
        },
      ),
    );
  }
}
