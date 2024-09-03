import 'package:flutter/material.dart';

class ReplacementScreen extends StatelessWidget {
  const ReplacementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Replacement Screen'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Open Another Screen'),
          ),
        ));
  }
}
