import 'package:financial_chart/src/markers/crossline/marker_handle.dart';
import 'package:flutter/material.dart';

class CrosslineMarkerHandle extends GMarkerHandle {
  CrosslineMarkerHandle({super.pos, super.child});

  @override
  Widget handleBuilder(BuildContext context) {
    return _handleBody(context);
  }

  Widget _handleBody(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(color: Colors.red),
    );
  }

  @override
  GMarkerHandle updatePos({required Offset pos}) {
    return CrosslineMarkerHandle(pos: pos, child: child);
  }
}
