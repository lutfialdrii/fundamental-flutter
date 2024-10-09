import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertest/provider/done_module_provider.dart';
import 'package:fluttertest/ui/module_page.dart';
import 'package:provider/provider.dart';

Widget createHomeScreens() => ChangeNotifierProvider<DoneModuleProvider>(
      create: (context) => DoneModuleProvider(),
      child: MaterialApp(
        home: ModulePage(),
      ),
    );

void main() {
  group(
    'Module List Page Widget Test',
    () {
      testWidgets(
        'Testing if Listview shows up',
        (WidgetTester tester) async {
          await tester.pumpWidget(createHomeScreens());
          expect(find.byType(ListView), findsOneWidget);
        },
      );

      testWidgets(
        'Test Done Button',
        (tester) async {
          await tester.pumpWidget(createHomeScreens());
          await tester.tap(find.byType(ElevatedButton).first);
          await tester.pumpAndSettle();
          expect(find.byIcon(Icons.done), findsNWidgets(2));
        },
      );
    },
  );
}
