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
  void showContextMenu(Offset offset) {
    showContextMenuCallCount++;
  }

  @override
  void hideContextMenu() {
    hideContextMenuCallCount++;
  }

  void verifyShowContextMenuCalled(int count) {
    expect(showContextMenuCallCount, count);
  }

  void verifyHideContextMenuCalled(int count) {
    expect(hideContextMenuCallCount, count);
  }
}

void verify(dynamic mockInstance) {}
