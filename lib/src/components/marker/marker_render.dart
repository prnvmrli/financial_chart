import 'package:financial_chart/financial_chart.dart';
import 'package:financial_chart/src/markers/crossline/marker_handle.dart';
import 'package:flutter/material.dart';

/// Base class for rendering a [GMarker].
///
/// [GMarkerRender] has different implementations from super [GRender] for it needs some extra parameters for rendering.
/// use [GMarkerRender.renderMarker] instead of super [GRender.render] to render a [GMarker].
abstract class GMarkerRender<M extends GMarker, T extends GMarkerTheme>
    extends GRender<M, T> {
  final GMarkerHandle? handle;

  const GMarkerRender({this.handle});

  void renderMarker({
    required Canvas canvas,
    required GChart chart,
    required GPanel panel,
    required GComponent component,
    required M marker,
    required Rect area,
    required T theme,
    GValueViewPort? valueViewPort,
    ValueNotifier<Map<String, GMarkerHandle>>? handles,
  }) {
    if (!component.visible || !marker.visible) {
      return;
    }
    final pointViewPort = chart.pointViewPort;
    if (!pointViewPort.isValid) {
      return;
    }
    final validValueViewPort = valueViewPort ?? panel.valueViewPorts.first;
    if (!validValueViewPort.isValid) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (marker is GCrosslineMarker) {
        final anchorPos = marker.anchor.toPosition(
          area: area,
          valueViewPort: validValueViewPort,
          pointViewPort: pointViewPort,
        );

        if (area.top > (anchorPos.dy - 15) ||
            area.bottom < (anchorPos.dy + 15)) {
          final hdls = {...?handles?.value};
          hdls.remove(marker.id);
          handles?.value = hdls;
        } else {
          handles?.value = {
            ...handles.value,
            ?marker.id: ?handle?.updatePos(pos: anchorPos),
          };
        }
      }
    });

    renderClipped(
      canvas: canvas,
      clipRect: area,
      render: () => doRenderMarker(
        canvas: canvas,
        chart: chart,
        panel: panel,
        component: component,
        marker: marker,
        area: area,
        theme: theme,
        pointViewPort: pointViewPort,
        valueViewPort: validValueViewPort,
      ),
    );
  }

  void doRenderMarker({
    required Canvas canvas,
    required GChart chart,
    required GPanel panel,
    required GComponent component,
    required M marker,
    required Rect area,
    required T theme,
    required GPointViewPort pointViewPort,
    required GValueViewPort valueViewPort,
  });

  @override
  void doRender({
    required Canvas canvas,
    required GChart chart,
    GPanel? panel,
    required M component,
    required Rect area,
    required T theme,
  }) {
    throw UnimplementedError("should call renderMarker for GMarkerRender");
  }
}
