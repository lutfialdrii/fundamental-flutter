import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_example/firebase_options.dart';
import 'package:firebase_example/pages/chat_page.dart';
import 'package:firebase_example/pages/login_page.dart';
import 'package:firebase_example/pages/register_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicoding Chatting',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        RegisterPage.id: (context) => const RegisterPage(),
        ChatPage.id: (context) => const ChatPage(),
      },
    );
  }
}
