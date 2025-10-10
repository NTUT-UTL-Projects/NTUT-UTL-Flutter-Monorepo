part of '../../seat_cushion_presentation.dart';

class SeatCushion3DMeshWidgetTheme
    extends ThemeExtension<SeatCushion3DMeshWidgetTheme> {
  /// The base fill color of the 3D mesh.
  Color baseColor;

  /// The color used for stroke outlines or mesh grid lines.
  Color strokeColor;

  /// Creates a theme for the seat cushion 3D mesh visualization.
  SeatCushion3DMeshWidgetTheme({
    required this.baseColor,
    required this.strokeColor,
  });

  @override
  SeatCushion3DMeshWidgetTheme copyWith({
    Color? baseColor,
    Color? strokeColor,
  }) =>
      SeatCushion3DMeshWidgetTheme(
        baseColor: baseColor ?? this.baseColor,
        strokeColor: strokeColor ?? this.strokeColor,
      );

  @override
  SeatCushion3DMeshWidgetTheme lerp(
      SeatCushion3DMeshWidgetTheme? other, double t) {
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

abstract class SeatCushion3DMeshWidgetUI {
  /// The height of the virtual camera above the mesh.
  /// Refer to [Sp3dFreeLookCamera.position]
  double get cameraHight;

  /// The focal length of the camera (controls zoom perspective).
  /// 
  /// Refer to [Sp3dFreeLookCamera.focusLength].
  double get focusLength;

  /// Maps a [SeatCushionUnitCornerPoint] (a single sensor corner point)
  /// 
  /// to a specific [Color] for visualization.
  Color pointToColor(ThemeData themeData, SeatCushionUnitCornerPoint point);

  /// Converts a [SeatCushionUnitCornerPoint] into a vertical displacement
  /// in the 3D mesh, defining the surface shape.
  double pointToHeight(ThemeData themeData, SeatCushionUnitCornerPoint point);
}

/// --------------------------------------------
/// [SeatCushion3DMeshView]
/// --------------------------------------------
///
/// A **stateless Flutter widget** built using the  
/// [`simple_3d_renderer`](https://pub.dev/packages/simple_3d_renderer) package  
/// that visualizes a [SeatCushionSet] as an interactive 3D mesh.
/// 
/// - The generic type parameter [T] represents the specific [SeatCushion3DMeshWidgetUI]
///   implementation that controls the rendering logic.
/// - This separation of UI logic (via [SeatCushion3DMeshWidgetUI]) and theme (via
///   [SeatCushion3DMeshWidgetTheme]) enables modular and reusable design.
///
/// **Requirements:**
/// - [SeatCushion3DMeshWidgetUI]
///   - It's for rendering logic (e.g., camera position, color mapping)
///   - It must be provided in the widget tree.
/// - [SeatCushion3DMeshWidgetTheme]
///   - It's for visual styling (e.g., base and stroke colors)
///   - It must be provided in the widget tree.
/// 
/// This view typically consumes real-time sensor data from a [SeatCushionSensor]
/// and visualizes it as a color/height mesh to represent seat pressure or deformation.
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
    final cameraPositin = seatCushionCenterPoint.copyWith(
      z: cameraHight,
    );

    /// If you want to reduce distortion, shoot from a distance at high magnification.
    final focusLength = context.select<T, double>((ui) => ui.focusLength);
    final camera = Sp3dFreeLookCamera(
      cameraPositin,
      focusLength,
    );
    
    final light = Sp3dLight(
      Sp3dV3D(0, 0, 1),
      syncCam: true,
    );

    /// Preserve the rotation and zoom states by keeping the controller outside the View.
    final rotationController = Sp3dCameraRotationController(
      lookAtTarget: seatCushionCenterPoint,
    );
    final zoomController = const Sp3dCameraZoomController();

    /// Keep the objects outside the View to make them traceable.
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
                  final bottomLeft = u.blPoint;
                  final topLeft = u.tlPoint;
                  final topRight = u.trPoint;
                  final bottomRight = u.brPoint;
                  return [
                    Sp3dV3D(bottomLeft.position.x, bottomLeft.position.y, ui.pointToHeight(themeData, bottomLeft)),
                    Sp3dV3D(topLeft.position.x, topLeft.position.y, ui.pointToHeight(themeData, topLeft)),
                    Sp3dV3D(topRight.position.x, topRight.position.y, ui.pointToHeight(themeData, topRight)),
                    Sp3dV3D(bottomRight.position.x, bottomRight.position.y, ui.pointToHeight(themeData, bottomRight)),
                  ];
                }) ?? List<List<Sp3dV3D>>.empty(),
                /// Base
                ...List.generate(
                  SeatCushion.unitsMaxRow,
                  (row) {
                    return List.generate(
                      SeatCushion.unitsMaxColumn,
                      (column) {
                        final bottomLeft = SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitCornerPointType.bottomLeft,
                          row: row,
                          column: column,
                        );
                        final topLeft = SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitCornerPointType.topLeft,
                          row: row,
                          column: column,
                        );
                        final topRight = SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitCornerPointType.topRight,
                          row: row,
                          column: column,
                        );
                        final bottomRight = SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitCornerPointType.bottomRight,
                          row: row,
                          column: column,
                        );

                        return [
                          Sp3dV3D(bottomLeft.x, bottomLeft.y, 0.0),
                          Sp3dV3D(topLeft.x, topLeft.y, 0.0),
                          Sp3dV3D(topRight.x, topRight.y, 0.0),
                          Sp3dV3D(bottomRight.x, bottomRight.y, 0.0),
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
                ...seatCushionSet?.left.units.expand((e) => e).map((u) {
                  return Sp3dMaterial(
                    ui.pointToColor(themeData, u.mmPoint),
                    true,
                    1,
                    themeExtension.strokeColor,
                  );
                }) ?? List<Sp3dMaterial>.empty(),
                /// Base
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
                  final bottomLeft = u.blPoint;
                  final topLeft = u.tlPoint;
                  final topRight = u.trPoint;
                  final bottomRight = u.brPoint;
                  return [
                    Sp3dV3D(bottomLeft.position.x, bottomLeft.position.y, ui.pointToHeight(themeData, bottomLeft)),
                    Sp3dV3D(topLeft.position.x, topLeft.position.y, ui.pointToHeight(themeData, topLeft)),
                    Sp3dV3D(topRight.position.x, topRight.position.y, ui.pointToHeight(themeData, topRight)),
                    Sp3dV3D(bottomRight.position.x, bottomRight.position.y, ui.pointToHeight(themeData, bottomRight)),
                  ];
                }) ?? List<List<Sp3dV3D>>.empty(),
                /// Base
                ...List.generate(
                  SeatCushion.unitsMaxRow,
                  (row) {
                    return List.generate(
                      SeatCushion.unitsMaxColumn,
                      (column) {
                        final bottomLeft = SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitCornerPointType.bottomLeft,
                          row: row,
                          column: column,
                        );
                        final topLeft = SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitCornerPointType.topLeft,
                          row: row,
                          column: column,
                        );
                        final topRight = SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitCornerPointType.topRight,
                          row: row,
                          column: column,
                        );
                        final bottomRight = SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                          type: SeatCushionUnitCornerPointType.bottomRight,
                          row: row,
                          column: column,
                        );

                        return [
                          Sp3dV3D(bottomLeft.x, bottomLeft.y, 0.0),
                          Sp3dV3D(topLeft.x, topLeft.y, 0.0),
                          Sp3dV3D(topRight.x, topRight.y, 0.0),
                          Sp3dV3D(bottomRight.x, bottomRight.y, 0.0),
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
                    ui.pointToColor(themeData, u.mmPoint),
                    true,
                    1,
                    themeExtension.strokeColor,
                  );
                }) ?? List<Sp3dMaterial>.empty(),
                /// Base
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
