import 'package:flutter/material.dart';

void main() {
  runApp(const UnconstrainedExample());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // alignment: Alignment(-1, -1),
      // alignment: Alignment.bottomRight,
      child: Container(
        color: Colors.red,
        padding: EdgeInsets.all(10),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.green,
        ),
      ),
    );
  }
}

class ConstrainedExample extends StatelessWidget {
  const ConstrainedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
        child: Container(
          // Width akan dibatasi oleh maxwidth sebesar 150
          width: 3000,
          height: 100,
          color: Colors.green,
        ),
      ),
    );
  }
}

class UnconstrainedExample extends StatelessWidget {
  const UnconstrainedExample({super.key});

  @override
  Widget build(BuildContext context) {
    //  Unconstrained box : widget yang tidak memberikan constraints pada widget di bawahnya.
    return UnconstrainedBox(
      child: Container(
        width: 1000,
        height: 100,
        color: Colors.purple,
      ),
    );
  }
}
