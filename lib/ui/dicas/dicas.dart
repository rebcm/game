import 'package:flutter/material.dart';

class Dicas extends StatefulWidget {
  @override
  _DicasState createState() => _DicasState();
}

class _DicasState extends State<Dicas> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void _showTooltip(Offset offset, String message) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy,
        child: CompositedTransformFollower(
          link: _layerLink,
          child: Material(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _hideTooltip,
        onHover: (hover) {
          if (hover) {
            Future.delayed(Duration(milliseconds: 500), () {
              if (_overlayEntry == null) {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                Offset offset = renderBox.localToGlobal(Offset.zero);
                _showTooltip(offset, 'Nome do Bloco');
              }
            });
          } else {
            _hideTooltip();
          }
        },
        child: Container(
          // Seu widget de bloco aqui
        ),
      ),
    );
  }
}
