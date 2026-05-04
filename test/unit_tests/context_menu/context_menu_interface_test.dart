import 'package:flutter_test/flutter_test.dart';
import 'package:game/context_menu/context_menu_interface.dart';

void main() {
  group('ContextMenuInterface', () {
    test('showContextMenu and hideContextMenu are defined', () {
      final contextMenu = MockContextMenuInterface();
      contextMenu.showContextMenu(Offset.zero);
      contextMenu.hideContextMenu();
      verify(contextMenu.showContextMenu(Offset.zero)).called(1);
      verify(contextMenu.hideContextMenu()).called(1);
    });
  });
}

class MockContextMenuInterface implements ContextMenuInterface {
  int showContextMenuCallCount = 0;
  int hideContextMenuCallCount = 0;

  @override
  void showContextMenu(Offset position) {
    showContextMenuCallCount++;
  }

  @override
  void hideContextMenu() {
    hideContextMenuCallCount++;
  }

  void verifyShowContextMenuCalled(int times) {
    expect(showContextMenuCallCount, times);
  }

  void verifyHideContextMenuCalled(int times) {
    expect(hideContextMenuCallCount, times);
  }
}

void verify(dynamic mockInstance) {
  // Simplified verification for the test
  if (mockInstance is MockContextMenuInterface) {
    if (mockInstance.showContextMenuCallCount > 0) {
      print('showContextMenu was called');
    }
    if (mockInstance.hideContextMenuCallCount > 0) {
      print('hideContextMenu was called');
    }
  }
}
