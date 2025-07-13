import 'package:flutter/material.dart';
import 'admin_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _roommateController = TextEditingController();
  final TextEditingController _choreController = TextEditingController();

  List<String> roommates = [];
  List<String> chores = [];

  void _addRoommate() {
    final name = _roommateController.text.trim();
    if (name.isNotEmpty && !roommates.contains(name)) {
      setState(() {
        roommates.add(name);
        _roommateController.clear();
      });
    }
  }

  void _addChore() {
    final task = _choreController.text.trim();
    if (task.isNotEmpty && !chores.contains(task)) {
      setState(() {
        chores.add(task);
        _choreController.clear();
      });
    }
  }

  void _continueToAdminScreen() {
    if (roommates.isNotEmpty && chores.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AdminScreen(roommates: roommates, chores: chores),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add at least 1 roommate and chore")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text("Add Roommates", style: TextStyle(fontSize: 18)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _roommateController,
                    decoration: const InputDecoration(labelText: 'Roommate Name'),
                  ),
                ),
                IconButton(onPressed: _addRoommate, icon: const Icon(Icons.add))
              ],
            ),
            Wrap(
              spacing: 8,
              children: roommates.map((name) => Chip(label: Text(name))).toList(),
            ),
            const SizedBox(height: 20),
            const Text("Add Chores", style: TextStyle(fontSize: 18)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _choreController,
                    decoration: const InputDecoration(labelText: 'Chore Name'),
                  ),
                ),
                IconButton(onPressed: _addChore, icon: const Icon(Icons.add))
              ],
            ),
            Wrap(
              spacing: 8,
              children: chores.map((task) => Chip(label: Text(task))).toList(),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _continueToAdminScreen,
              child: const Text("Start Managing Chores"),
            ),
          ],
        ),
      ),
    );
  }
}
