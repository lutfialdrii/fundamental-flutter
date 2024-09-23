import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_exercise_app/done_module_provider.dart';

class ModuleList extends StatelessWidget {
  const ModuleList({super.key});

  final List<String> _moduleList = const [
    'Modul 1 - Pengenalan Dart',
    'Modul 2 - Program Dart Pertamamu',
    'Modul 3 - Dart Fundamental',
    'Modul 4 - Control Flow',
    'Modul 5 - Collections',
    'Modul 6 - Object Oriented Programming',
    'Modul 7 - Functional Styles',
    'Modul 8 - Dart Type System',
    'Modul 9 - Dart Futures',
    'Modul 10 - Effective Dart',
  ];

  // final List<String> _doneModuleList = const [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _moduleList.length,
      itemBuilder: (context, index) {
        return Consumer<DoneModuleProvider>(
          builder: (context, DoneModuleProvider data, widget) {
            return ModuleTile(
              moduleName: _moduleList[index],
              isDone: data.doneModuleList.contains(_moduleList[index]),
              onClick: () {
                data.complete(_moduleList[index]);
              },
            );
          },
        );
      },
    );
  }
}

class ModuleTile extends StatelessWidget {
  final String moduleName;
  final bool isDone;
  final Function() onClick;
  const ModuleTile(
      {super.key,
      required this.moduleName,
      required this.isDone,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(moduleName),
      trailing: isDone
          ? Icon(Icons.done)
          : ElevatedButton(onPressed: onClick, child: const Text('Done')),
    );
  }
}
