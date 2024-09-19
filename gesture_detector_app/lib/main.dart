import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double boxSize = 150;
  int numTaps = 0;
  int numDoubleTaps = 0;
  int numLongpress = 0;
  double posX = 0;
  double posY = 0;

  void center(BuildContext context) {
    posX = (MediaQuery.of(context).size.width / 2) - boxSize / 2;
    posY = (MediaQuery.of(context).size.height / 2) - boxSize / 2 - 30;

    setState(() {
      this.posX = posX;
      this.posY = posY;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (posX == 0) {
      center(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture Detector App'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: posY,
            left: posX,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  numTaps++;
                });
              },
              onDoubleTap: () {
                setState(() {
                  numDoubleTaps++;
                });
              },
              onLongPress: () {
                setState(() {
                  numLongpress++;
                });
              },
              // onVerticalDragUpdate: (details) {
              //   print(details);
              //   setState(() {
              //     double delta = details.delta.dy;
              //     posY += delta;
              //   });
              // },
              // onHorizontalDragUpdate: (details) {
              //   print(details);
              //   setState(() {
              //     double delta = details.delta.dx;
              //     posX += delta;
              //   });
              // },
              onPanUpdate: (details) {
                setState(() {
                  double deltaX = details.delta.dx;
                  double deltaY = details.delta.dy;
                  posX += deltaX;
                  posY += deltaY;
                });
              },
              child: Container(
                width: boxSize,
                height: boxSize,
                decoration: BoxDecoration(color: Colors.red),
                child: Column(
                  children: [Text('PosX : $posX - PosY: $posY')],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.yellow,
        padding: EdgeInsets.all(10),
        child: Text(
          'Taps: $numTaps - Double Taps: $numDoubleTaps - Long Press: $numLongpress',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
