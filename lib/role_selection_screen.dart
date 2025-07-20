import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'roommate_screen.dart'; // You’ll create this next

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Housemate App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Select Your Role", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const WelcomeScreen()));
              },
              child: const Text("Admin"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RoommateScreen()));
              },
              child: const Text("Roommate"),
            ),
          ],
        ),
      ),
    );
  }
}
