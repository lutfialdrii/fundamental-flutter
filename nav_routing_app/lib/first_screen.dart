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
                Navigator.pushNamed(context, '/secondScreen');
              },
              child: const Text('Goes to Second Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/secondScreenWithData',
                    arguments: 'Hello from first');
              },
              child: const Text('Navigation with Data'),
            ),
            ElevatedButton(
              onPressed: () async {
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final result =
                    await Navigator.pushNamed(context, '/returnDataScreen');
                final snackbar = SnackBar(content: Text('Hasil : $result'));
                scaffoldMessenger.showSnackBar(snackbar);
              },
              child: const Text('Return data from another screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/replacementScreen');
              },
              child: const Text('Replace Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
