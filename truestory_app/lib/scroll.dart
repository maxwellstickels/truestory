import 'package:flutter/material.dart';

class ScrollRoute extends StatelessWidget {
  const ScrollRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('This is the Scroll.', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 30)),
            const SizedBox(height: 30),
            const Text('The scrollable feed where your friends\' posts live!'),
            const SizedBox(height: 30),
            const Text('(May or may not be a work in progress. You be the judge.)'),
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