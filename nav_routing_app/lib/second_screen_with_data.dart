import 'package:flutter/material.dart';

class SecondScreenWithData extends StatelessWidget {
  final String data;
  const SecondScreenWithData({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second screen with data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            )
          ],
        ),
      ),
    );
  }
}
