import 'package:flutter/material.dart';
import 'package:game/context_menu/context_menu_interface.dart';

class ContextMenu with ContextMenuInterface {
  OverlayEntry? _overlayEntry;

  @override
  void showContextMenu(Offset offset) {
    hideContextMenu();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy,
        child: Material(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  title: Text('Option 1'),
                  onTap: () {
                    // Handle option 1 tap
                  },
                ),
                ListTile(
                  title: Text('Option 2'),
                  onTap: () {
                    // Handle option 2 tap
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
    Overlay.of(navigatorKey.currentContext!)?.insert(_overlayEntry!);
  }

  @override
  void hideContextMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

final navigatorKey = GlobalKey<NavigatorState>();
