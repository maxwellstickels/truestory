import 'package:flutter/material.dart';
/*class ScrollRoute extends StatelessWidget {
  const ScrollRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Scroll is where you go to see your friends' posts!'),
      ),
      body: Center(
      ),
    );
  }
}
*/
class ProfileRoute extends StatelessWidget {
  const ProfileRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('This is your Profile.', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 30)),
            const SizedBox(height: 30),
            const Text('All your information is here!'),
            const SizedBox(height: 30),
            const Text('Or at least, it\'s supposed to be here.'),
            const SizedBox(height: 30),
            const Text('Say, you don\'t quite seem yourself lately...'),
            const SizedBox(height: 30),
            ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back to Home'),
          ),
          ]
        ),
      ),
    );
  }
}