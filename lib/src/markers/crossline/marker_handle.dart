import 'package:flutter/material.dart';

abstract class GMarkerHandle {
  final Offset? pos;
  final Widget? child;
  final VoidCallback? onCancel;

  GMarkerHandle({this.pos, this.child, this.onCancel});

  Widget handleBuilder(BuildContext context);

  GMarkerHandle updatePos({required Offset pos});
}
