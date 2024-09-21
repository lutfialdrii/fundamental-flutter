import 'package:cupertino_exercise_app/pages/category_page.dart';
import 'package:flutter/cupertino.dart';

class FeedsPage extends StatelessWidget {
  const FeedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Feeds Page'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Feeds Page',
              style:
                  CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
            ),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              child: const Text('Select Category'),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      title: const Text('Select Category'),
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const CategoryPage(
                                      selectedCategory: 'Technology'),
                                ));
                          },
                          child: const Text('Technology'),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const CategoryPage(
                                      selectedCategory: 'Sport'),
                                ));
                          },
                          child: const Text('Sport'),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const CategoryPage(
                                      selectedCategory: 'Business'),
                                ));
                          },
                          child: const Text('Business'),
                        )
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
