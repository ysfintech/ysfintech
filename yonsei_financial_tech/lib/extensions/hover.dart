import 'dart:html' as html;

import 'package:flutter/material.dart';

class Hover extends StatefulWidget {
  final child, onTap;

  Hover({this.child, this.onTap});

  @override
  _HoverState createState() => _HoverState();
}

class _HoverState extends State<Hover> {
  static final appContainer =
      html.window.document.getElementById('app-container');
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onHover: (hover) {
          if (mounted) {
            setState(() {
              appContainer?.style.cursor = 'pointer';
            });
          }
        },
        hoverColor: Colors.transparent,
        onTap: widget.onTap,
        child: widget.child);
  }
}
