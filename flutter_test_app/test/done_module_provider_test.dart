import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertest/provider/done_module_provider.dart';

void main() {
  test(
    'should contain new item when module completed',
    () {
      // Arrange
      var doneModuleProvider = DoneModuleProvider();
      var testModuleName = 'Test Module';

      // act
      doneModuleProvider.complete(testModuleName);

      // Assert
      var result = doneModuleProvider.doneModuleList.contains(testModuleName);
      expect(result, true);
    },
  );
}
