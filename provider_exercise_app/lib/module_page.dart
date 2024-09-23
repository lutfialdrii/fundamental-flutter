import 'package:flutter/material.dart';

import 'widgets/done_module_list.dart';
import 'widgets/module_list.dart';

class ModulePage extends StatelessWidget {
  ModulePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memulai Pemrograman Dengan Dart"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoneModuleList(),
                    ));
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: ModuleList(),
    );
  }
}
