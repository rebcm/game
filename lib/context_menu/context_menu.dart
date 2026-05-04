import 'package:flutter/material.dart';
import 'context_menu_interface.dart';

class ContextMenu implements ContextMenuInterface {
  final BuildContext _context;

  ContextMenu(this._context);

  @override
  void showContextMenu(Offset position) {
    final RenderBox overlay = _context.findRenderObject() as RenderBox;
    final RelativeRect positionRelativeToOverlay = RelativeRect.fromRect(
      Rect.fromPoints(position, position),
      Offset.zero & overlay.size,
    );
    showMenu(
      context: _context,
      position: positionRelativeToOverlay,
      items: [
        PopupMenuItem(child: Text('Menu Item 1')),
        PopupMenuItem(child: Text('Menu Item 2')),
      ],
    );
  }

  @override
  void hideContextMenu() {
    Navigator.of(_context).pop();
  }
}
