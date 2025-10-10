part of '../../seat_cushion_presentation.dart';

class SeatCushion3DMeshWidgetTheme extends ThemeExtension<SeatCushion3DMeshWidgetTheme> {
  Color baseColor;
  Color strokeColor;

  SeatCushion3DMeshWidgetTheme({
    required this.baseColor,
    required this.strokeColor,
  });

  @override
  SeatCushion3DMeshWidgetTheme copyWith({
    Color? baseColor,
    Color? strokeColor,
  }) => SeatCushion3DMeshWidgetTheme(
    baseColor: baseColor ?? this.baseColor,
    strokeColor: strokeColor ?? this.strokeColor,
  );

  @override
  SeatCushion3DMeshWidgetTheme lerp(SeatCushion3DMeshWidgetTheme? other, double t) {
    if (other is! SeatCushion3DMeshWidgetTheme) return this;
    return SeatCushion3DMeshWidgetTheme(
      strokeColor: Color.lerp(
          strokeColor,
          other.strokeColor,
          t,
        ) ??
        strokeColor,
      baseColor: Color.lerp(
          baseColor,
          other.baseColor,
          t,
        ) ??
        baseColor,
    );
  }

}

class SeatCushion3DMeshWidgetUI {
  final double cameraHight;
  final double focusLength;
  final double Function(SeatCushionUnitPoint point) pointToValue;
  final Color Function(ThemeData themeData, double value) valueToColor;
  final double valueScale;

  SeatCushion3DMeshWidgetUI({
    required this.cameraHight,
    required this.focusLength,
    required this.pointToValue,
    required this.valueToColor,
    required this.valueScale,
  });

  SeatCushion3DMeshWidgetUI copyWith({
    double? cameraHight,
    double? focusLength,
    double Function(SeatCushionUnitPoint point)? pointToValue,
    Color Function(ThemeData themeData, double value)? valueToColor,
    double ? valueScale,
  }) => SeatCushion3DMeshWidgetUI(
    cameraHight: cameraHight ?? this.cameraHight,
    focusLength: focusLength ?? this.focusLength,
    pointToValue: pointToValue ?? this.pointToValue,
    valueToColor: valueToColor ?? this.valueToColor,
    valueScale: valueScale ?? this.valueScale,
  );

}

class SeatCushion3DMeshView<T extends SeatCushion3DMeshWidgetUI> extends StatelessWidget {
  const SeatCushion3DMeshView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final world = Sp3dWorld([]);

    final seatCushionCenterPoint = Sp3dV3D(
      (LeftSeatCushion.basePosition.x + RightSeatCushion.basePosition.x) / 2.0,
      (LeftSeatCushion.basePosition.y + RightSeatCushion.basePosition.y) / 2.0,
      0,
    );
    final cameraHight = context.select<T, double>((ui) => ui.cameraHight);
    final cameraPoint = seatCushionCenterPoint.copyWith(
      z: cameraHight,
    );

    // If you want to reduce distortion, shoot from a distance at high magnification.
    final focusLength = context.select<T, double>((ui) => ui.focusLength);
    final camera = Sp3dFreeLookCamera(
      cameraPoint,
      focusLength,
    );
    
    final light = Sp3dLight(
      Sp3dV3D(0, 0, 1),
      syncCam: true,
    );

    // Preserve the rotation and zoom states by keeping the controller outside the View.
    final rotationController = Sp3dCameraRotationController(
      lookAtTarget: seatCushionCenterPoint,
    );
    final zoomController = const Sp3dCameraZoomController();

    // Keep the objects outside the View to make them traceable.
    Sp3dObj? leftObjBuffer;
    Sp3dObj? rightObjBuffer;
    return FutureBuilder(
      future: world.initImages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            final themeData = Theme.of(context);
            final themeExtension = themeData.extension<SeatCushion3DMeshWidgetTheme>()!;
            final mediaQuery = MediaQuery.of(context);
            final seatCushionSet = context.watch<SeatCushionSet?>();
            final ui = context.watch<T>();

            if(leftObjBuffer != null) {
              world.remove(leftObjBuffer!);
            }
            {
              final unserialized = [
                ...seatCushionSet?.left.units.expand((e) => e).map((u) {
                  final lb = u.lbPoint;
                  final lt = u.ltPoint;
                  final rt = u.rtPoint;
                  final rb = u.rbPoint;
                  return [
                    Sp3dV3D(lb.position.x, lb.position.y, ui.pointToValue(lb) * ui.valueScale),
                    Sp3dV3D(lt.position.x, lt.position.y, ui.pointToValue(lt) * ui.valueScale),
                    Sp3dV3D(rt.position.x, rt.position.y, ui.pointToValue(rt) * ui.valueScale),
                    Sp3dV3D(rb.position.x, rb.position.y, ui.pointToValue(rb) * ui.valueScale),
                  ];
                }) ?? List<List<Sp3dV3D>>.empty(),
                // Base
                ...List.generate(
                  SeatCushion.unitsMaxRow,
                  (row) {
                    return List.generate(
                      SeatCushion.unitsMaxColumn,
                      (column) {
                        final lt = SeatCushionUnitPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitPointType.lt,
                          row: row,
                          column: column,
                        );
                        final lb = SeatCushionUnitPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitPointType.lb,
                          row: row,
                          column: column,
                        );
                        final rb = SeatCushionUnitPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitPointType.rb,
                          row: row,
                          column: column,
                        );
                        final rt = SeatCushionUnitPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitPointType.rt,
                          row: row,
                          column: column,
                        );

                        return [
                          Sp3dV3D(lb.x, lb.y, 0.0),
                          Sp3dV3D(lt.x, lt.y, 0.0),
                          Sp3dV3D(rt.x, rt.y, 0.0),
                          Sp3dV3D(rb.x, rb.y, 0.0),
                        ];
                      },
                    );
                  },
                ).expand((e) => e),
                ...[
                  [
                    // rb
                    Sp3dV3D(0 + (SeatCushion.deviceWidth / 2.0), 0 + (SeatCushion.deviceHeight / 2.0), 0),
                    // rt
                    Sp3dV3D(0 + (SeatCushion.deviceWidth / 2.0), 0 - (SeatCushion.deviceHeight / 2.0), 0),
                    // lt
                    Sp3dV3D(0 - (SeatCushion.deviceWidth / 2.0), 0 - (SeatCushion.deviceHeight / 2.0), 0),
                    // lb
                    Sp3dV3D(0 - (SeatCushion.deviceWidth / 2.0), 0 + (SeatCushion.deviceHeight / 2.0), 0),
                  ],
                ],
              ];
              final serialized = UtilSp3dList.serialize(unserialized);
              final fragments = unserialized.indexed.map((e) {
                final index = e.$1;
                final face = e.$2;
                return Sp3dFragment([
                  Sp3dFace(
                    UtilSp3dList.getIndexes(
                      face, 
                      index * face.length,
                    ), 
                    index,
                  ),
                ]);
              }).toList();
              final materials = [
                ...seatCushionSet?.left.units.expand((e) => e).map((u) {
                  return Sp3dMaterial(
                    ui.valueToColor(themeData, ui.pointToValue(u.mmPoint)),
                    true,
                    1,
                    themeExtension.strokeColor,
                  );
                }) ?? List<Sp3dMaterial>.empty(),
                // Base
                ...List.generate(
                  SeatCushion.unitsMaxIndex,
                  (_) {
                    return Sp3dMaterial(
                      themeExtension.baseColor,
                      true,
                      1,
                      themeExtension.strokeColor,
                    );
                  },
                ),
              ];
              leftObjBuffer = Sp3dObj(
                serialized,
                fragments,
                materials,
                [],
              );
            }
            world.add(leftObjBuffer!, Sp3dV3D(LeftSeatCushion.basePosition.x, LeftSeatCushion.basePosition.y, 0.0));

            if(rightObjBuffer != null) {
              world.remove(rightObjBuffer!);
            }
            {
              final unserialized = [
                ...seatCushionSet?.right.units.expand((e) => e).map((u) {
                  final lb = u.lbPoint;
                  final lt = u.ltPoint;
                  final rt = u.rtPoint;
                  final rb = u.rbPoint;
                  return [
                    Sp3dV3D(lb.position.x, lb.position.y, ui.pointToValue(lb) * ui.valueScale),
                    Sp3dV3D(lt.position.x, lt.position.y, ui.pointToValue(lt) * ui.valueScale),
                    Sp3dV3D(rt.position.x, rt.position.y, ui.pointToValue(rt) * ui.valueScale),
                    Sp3dV3D(rb.position.x, rb.position.y, ui.pointToValue(rb) * ui.valueScale),
                  ];
                }) ?? List<List<Sp3dV3D>>.empty(),
                // Base
                ...List.generate(
                  SeatCushion.unitsMaxRow,
                  (row) {
                    return List.generate(
                      SeatCushion.unitsMaxColumn,
                      (column) {
                        final lt = SeatCushionUnitPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitPointType.lt,
                          row: row,
                          column: column,
                        );
                        final lb = SeatCushionUnitPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitPointType.lb,
                          row: row,
                          column: column,
                        );
                        final rb = SeatCushionUnitPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitPointType.rb,
                          row: row,
                          column: column,
                        );
                        final rt = SeatCushionUnitPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitPointType.rt,
                          row: row,
                          column: column,
                        );

                        return [
                          Sp3dV3D(lb.x, lb.y, 0.0),
                          Sp3dV3D(lt.x, lt.y, 0.0),
                          Sp3dV3D(rt.x, rt.y, 0.0),
                          Sp3dV3D(rb.x, rb.y, 0.0),
                        ];
                      },
                    );
                  },
                ).expand((e) => e),
              ];
              final serialized = UtilSp3dList.serialize(unserialized);
              final fragments = unserialized.indexed.map((e) {
                final index = e.$1;
                final face = e.$2;
                return Sp3dFragment([
                  Sp3dFace(
                    UtilSp3dList.getIndexes(
                      face, 
                      index * face.length,
                    ), 
                    index,
                  ),
                ]);
              }).toList();
              final materials = [
                ...seatCushionSet?.right.units.expand((e) => e).map((u) {
                  return Sp3dMaterial(
                    ui.valueToColor(themeData, ui.pointToValue(u.mmPoint)),
                    true,
                    1,
                    themeExtension.strokeColor,
                  );
                }) ?? List<Sp3dMaterial>.empty(),
                // Base
                ...List.generate(
                  SeatCushion.unitsMaxIndex,
                  (_) {
                    return Sp3dMaterial(
                      themeExtension.baseColor,
                      true,
                      1,
                      themeExtension.strokeColor,
                    );
                  },
                ),
              ];
              rightObjBuffer = Sp3dObj(
                serialized,
                fragments,
                materials,
                [],
              );
            }
            world.add(rightObjBuffer!, Sp3dV3D(RightSeatCushion.basePosition.x, RightSeatCushion.basePosition.y, 0.0));

            final size = Size(
              mediaQuery.size.width,
              mediaQuery.size.height,
            );
            final worldOrigin = Sp3dV2D(
              mediaQuery.size.width / 2,
              mediaQuery.size.height / 2,
            );
            return Sp3dRenderer(
              size,
              worldOrigin,
              world,
              camera,
              light,
              useUserGesture: true,
              rotationController: rotationController,
              zoomController: zoomController,
              useClipping: true,
              allowUserWorldZoom: false,
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }
}
