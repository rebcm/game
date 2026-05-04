import 'package:flutter/material.dart';
import 'package:game/context_menu/context_menu_interface.dart';

class ContextMenu implements ContextMenuInterface {
  final BuildContext _context;

  ContextMenu(this._context);

  @override
  void showContextMenu(Offset offset) {
    final RenderBox renderBox = _context.findRenderObject() as RenderBox;
    final Offset localOffset = renderBox.globalToLocal(offset);
    final PopupMenuThemeData popupMenuThemeData = PopupMenuTheme.of(_context);
    showMenu(
      context: _context,
      position: RelativeRect.fromLTRB(
        localOffset.dx,
        localOffset.dy,
        localOffset.dx,
        localOffset.dy,
      ),
      items: [
        PopupMenuItem(child: Text('Menu Item 1')),
        PopupMenuItem(child: Text('Menu Item 2')),
      ],
      elevation: popupMenuThemeData.elevation,
      shape: popupMenuThemeData.shape,
    );
  }

  @override
  void hideContextMenu() {
    Navigator.of(_context).pop();
  }
}
