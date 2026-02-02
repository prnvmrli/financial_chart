import 'package:financial_chart/src/markers/crossline/marker_handle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderLineMarkerHandle extends GMarkerHandle {
  OrderLineMarkerHandle({super.child, super.pos, super.onCancel});

  final ValueNotifier _isSelected = ValueNotifier(false);

  @override
  Widget handleBuilder(BuildContext context) => _handleBody(context);

  Widget _handleBody(BuildContext context) {
    // TODO(Pranav): Change this widget later
    // to a reactive widget which changes to edit mode with draggable and
    // close buttons

    return Container(
      height: 30,
      padding: EdgeInsets.only(left: 6),
      decoration: BoxDecoration(
        color: Color(0xFFD3D3D3),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ?child,
          InkWell(
            onTap: onCancel?.call,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Icon(Icons.close, color: Colors.red, size: 14),
            ),
          ),
        ],
      ),
    );

    // return ValueListenableBuilder(
    //   valueListenable: _isSelected,
    //   builder: (context, value, _) {
    //     return Container(
    //       height: 30,
    //       padding: EdgeInsets.symmetric(horizontal: 6),
    //       decoration: BoxDecoration(
    //         border: Border.all(),
    //         borderRadius: BorderRadius.circular(2),
    //       ),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           if (value)
    //             GestureDetector(
    //               onTap: () {
    //                 super.onCancel?.call();
    //               },
    //               child: Icon(Icons.cancel_outlined),
    //             ),
    //           TapRegion(
    //             onTapInside: (_) => _onTap(value),
    //             onTapOutside: (_) => _onTap(value),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [?child, if (!value) Icon(Icons.arrow_right)],
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }

  void _onTap(bool value) {
    HapticFeedback.lightImpact();
    _isSelected.value = !value;
  }

  @override
  GMarkerHandle updatePos({required Offset pos}) {
    return OrderLineMarkerHandle(pos: pos, child: child, onCancel: onCancel);
  }
}
