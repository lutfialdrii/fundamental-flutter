import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/secondScreenWithData',
                    arguments: 'Hello from First Screen!');
              },
              child: const Text('Goes to Second Screen'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Navigation with Data'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Return data from another screen'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Replace Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
