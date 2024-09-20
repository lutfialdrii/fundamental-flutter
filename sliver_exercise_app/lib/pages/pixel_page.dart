import 'package:flutter/material.dart';
import 'package:sliver_exercise_app/strings.dart';

class PixelPage extends StatelessWidget {
  const PixelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/pixel_google.jpg',
                    fit: BoxFit.fitWidth,
                  ),
                  title: const Text('Google Pixel'),
                  titlePadding: const EdgeInsets.only(left: 10, bottom: 10),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        r'$735',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Container(
                        color: Colors.black26,
                        padding: const EdgeInsets.all(8),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.collections,
                              color: Colors.white,
                            ),
                            Text(
                              '6 Photos',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Stock hanya 5 buah',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 8),
                  const Text(contentText),
                  const SizedBox(height: 8),
                  Text(
                    'Spesifikasi',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 8),
                  Table(
                    columnWidths: const {1: FractionColumnWidth(0.7)},
                    children: const [
                      TableRow(
                        children: [
                          Text('Display'),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(contentSpecsDisplay),
                          )
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Size'),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(contentSpecsSize),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Battery'),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(contentSpecsBattery),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Dijual oleh',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(9),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/photo_2.jpg'),
                          radius: 24,
                        ),
                      ),
                      Text('Narenda Wicaksono'),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Added to Cart')));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white),
                        child: const Text('Beli')),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
