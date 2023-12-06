import 'package:flutter/material.dart';

class NotifRoute extends StatelessWidget {
  const NotifRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Ding Dong!', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 30)),
            const SizedBox(height: 30),
            const Text('(Sorry, I really shouldn\'t call you that.)', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            const Text('This is where your notifications live.'),
            const SizedBox(height: 30),
            const Text('You don\'t have any at the moment.'),
            const SizedBox(height: 30),
            ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back to Home'),
          ),
          ]
        ),
      )
    );
  }
}