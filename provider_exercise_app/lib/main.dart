import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_exercise_app/done_module_provider.dart';
import 'module_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => DoneModuleProvider(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              // useMaterial3: true,
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          home: ModulePage()),
    );
  }
}
