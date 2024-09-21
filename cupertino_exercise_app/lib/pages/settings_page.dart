import 'package:cupertino_exercise_app/pages/home_page.dart';
import 'package:flutter/cupertino.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings Page'),
      ),
      child: Center(
          child: CupertinoButton(
        child: const Text('Log out'),
        onPressed: () {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('Are you sure to log out?'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, CupertinoPageRoute(
                        builder: (context) {
                          return const HomePage();
                        },
                      ));
                    },
                  ),
                ],
              );
            },
          );
        },
      )),
    );
  }
}
