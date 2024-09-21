import 'package:flutter/material.dart';

import '../widgets/learning_path_list.dart';

class LearningPathPage extends StatelessWidget {
  const LearningPathPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dicoding Learning Path'),
      ),
      body: const LearningPathList(),
    );
  }
}
