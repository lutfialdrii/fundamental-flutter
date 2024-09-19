import 'package:flutter/material.dart';

void main() {
  runApp(RowColumnExample());
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

class RowColumnExample extends StatelessWidget {
  const RowColumnExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                color: Colors.red,
                child: Text('Hello Container Red Consequat sunt ullamco fugiat anim nisi aute. Fugiat occaecat mollit esse adipisicing nulla exercitation aliqua voluptate culpa occaecat cupidatat. Est nisi enim pariatur enim labore officia ad laborum voluptate. Laborum Lorem ad amet fugiat veniam adipisicing exercitation dolor et velit. Anim voluptate laborum eiusmod et aliqua laboris veniam aliqua magna tempor sit occaecat consequat. Reprehenderit dolore sint ut aliqua ea et sint velit id eiusmod eiusmod mollit cillum.'),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.blue,
                child: Text('Hello Container Blue'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
