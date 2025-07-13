import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _chores = [];
  final TextEditingController _choreController = TextEditingController();

  void _addChore() {
    final chore = _choreController.text.trim();
    if (chore.isNotEmpty) {
      setState(() {
        _chores.add(chore);
        _choreController.clear();
      });
    }
  }

  void _deleteChore(int index) {
    setState(() {
      _chores.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HouseMate Chores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _choreController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a chore (e.g., Clean kitchen)',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addChore,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _chores.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_chores[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteChore(index),
                      ),
                    ),
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
