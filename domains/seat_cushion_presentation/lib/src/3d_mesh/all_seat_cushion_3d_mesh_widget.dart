import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_cushion/seat_cushion.dart';
import 'package:simple_3d/simple_3d.dart';
import 'package:simple_3d_renderer/simple_3d_renderer.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:util_simple_3d/util_simple_3d.dart';

part 'all_seat_cushion_3d_mesh_widget.tailor.dart';

@immutable
@TailorMixin()
class AllSeatCushion3DMeshWidgetTheme
    extends ThemeExtension<AllSeatCushion3DMeshWidgetTheme>
    with _$AllSeatCushion3DMeshWidgetThemeTailorMixin {
  /// The base fill color of the 3D mesh.
  @override
  final Color baseColor;

  /// Maps a [SeatCushionUnitCornerPoint] to a specific [Color] for visualization.
  @override
  final Color Function(SeatCushionUnitCornerPoint point) pointToColor;

  /// Converts a [SeatCushionUnitCornerPoint] into a vertical displacement
  /// in the 3D mesh, defining the surface shape.
  @override
  final double Function(SeatCushionUnitCornerPoint point) pointToHeight;

  /// The color used for stroke outlines or mesh grid lines.
  @override
  final Color strokeColor;

  /// Creates a theme for the seat cushion 3D mesh visualization.
  AllSeatCushion3DMeshWidgetTheme({
    required this.baseColor,
    required this.pointToColor,
    required this.pointToHeight,
    required this.strokeColor,
  });
}

/// --------------------------------------------
/// [AllSeatCushion3DMeshView]
/// --------------------------------------------
///
/// A **stateless Flutter widget** built using the
/// [`simple_3d_renderer`](https://pub.dev/packages/simple_3d_renderer) package
/// that visualizes a [LeftSeatCushion] and a [RightSeatCushion] as an interactive 3D mesh.
///
/// - The generic type parameter [T] represents the specific [AllSeatCushion3DMeshWidgetTheme]
///   implementation that controls the rendering logic.
///
/// **Themes:**
/// - [AllSeatCushion3DMeshWidgetTheme]
class AllSeatCushion3DMeshView<T extends AllSeatCushion3DMeshWidgetTheme>
    extends StatelessWidget {
  const AllSeatCushion3DMeshView({super.key});

  @override
  Widget build(BuildContext context) {
    final world = Sp3dWorld([]);

    final seatCushionCenterPoint = Sp3dV3D(
      (LeftSeatCushion.basePosition.x + RightSeatCushion.basePosition.x) / 2.0,
      (LeftSeatCushion.basePosition.y + RightSeatCushion.basePosition.y) / 2.0,
      0,
    );

    final light = Sp3dLight(Sp3dV3D(0, 0, 1), syncCam: true);

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
            return LayoutBuilder(
              builder: (context, constraints) {
                final layoutAspectRatio =
                    constraints.maxWidth / constraints.maxHeight;
                final size = Size(constraints.maxWidth, constraints.maxHeight);
                final worldOrigin = Sp3dV2D(
                  constraints.maxWidth / 2.0,
                  constraints.maxHeight / 2.0,
                );
                final setMaxEdgeSize = (SeatCushionSet.deviceAspectRatio > 1)
                    ? SeatCushionSet.deviceWidth
                    : SeatCushionSet.deviceHeight;
                final layoutMaxRatio =
                    (layoutAspectRatio > SeatCushionSet.deviceAspectRatio)
                    ? (layoutAspectRatio / SeatCushionSet.deviceAspectRatio)
                    : (SeatCushionSet.deviceAspectRatio / layoutAspectRatio);
                final cameraHeight = setMaxEdgeSize * 10.0 * layoutMaxRatio;
                // If you want to reduce distortion, shoot from a distance at high magnification.
                final focusLength = cameraHeight;

                final camera = Sp3dFreeLookCamera(
                  seatCushionCenterPoint.copyWith(z: cameraHeight),
                  focusLength,
                );

                return Builder(
                  builder: (context) {
                    final themeData = Theme.of(context);
                    final themeExtension = themeData
                        .extension<AllSeatCushion3DMeshWidgetTheme>()!;

                    final left = context.watch<LeftSeatCushion?>();
                    if (leftObjBuffer != null) {
                      world.remove(leftObjBuffer!);
                    }
                    {
                      final unserialized = [
                        ...left?.units.expand((e) => e).map((u) {
                              final bottomLeft = u.blPoint;
                              final topLeft = u.tlPoint;
                              final topRight = u.trPoint;
                              final bottomRight = u.brPoint;
                              return [
                                Sp3dV3D(
                                  bottomLeft.position.x,
                                  bottomLeft.position.y,
                                  themeExtension.pointToHeight(bottomLeft),
                                ),
                                Sp3dV3D(
                                  topLeft.position.x,
                                  topLeft.position.y,
                                  themeExtension.pointToHeight(topLeft),
                                ),
                                Sp3dV3D(
                                  topRight.position.x,
                                  topRight.position.y,
                                  themeExtension.pointToHeight(topRight),
                                ),
                                Sp3dV3D(
                                  bottomRight.position.x,
                                  bottomRight.position.y,
                                  themeExtension.pointToHeight(bottomRight),
                                ),
                              ];
                            }) ??
                            List<List<Sp3dV3D>>.empty(),

                        /// Base
                        ...List.generate(SeatCushion.unitsMaxRow, (row) {
                          return List.generate(SeatCushion.unitsMaxColumn, (
                            column,
                          ) {
                            final bottomLeft =
                                SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                                  type:
                                      SeatCushionUnitCornerPointType.bottomLeft,
                                  row: row,
                                  column: column,
                                );
                            final topLeft =
                                SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                                  type: SeatCushionUnitCornerPointType.topLeft,
                                  row: row,
                                  column: column,
                                );
                            final topRight =
                                SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                                  type: SeatCushionUnitCornerPointType.topRight,
                                  row: row,
                                  column: column,
                                );
                            final bottomRight =
                                SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                                  type: SeatCushionUnitCornerPointType
                                      .bottomRight,
                                  row: row,
                                  column: column,
                                );

                            return [
                              Sp3dV3D(bottomLeft.x, bottomLeft.y, 0.0),
                              Sp3dV3D(topLeft.x, topLeft.y, 0.0),
                              Sp3dV3D(topRight.x, topRight.y, 0.0),
                              Sp3dV3D(bottomRight.x, bottomRight.y, 0.0),
                            ];
                          });
                        }).expand((e) => e),
                      ];
                      final serialized = UtilSp3dList.serialize(unserialized);
                      final fragments = unserialized.indexed.map((e) {
                        final index = e.$1;
                        final face = e.$2;
                        return Sp3dFragment([
                          Sp3dFace(
                            UtilSp3dList.getIndexes(face, index * face.length),
                            index,
                          ),
                        ]);
                      }).toList();
                      final materials = [
                        ...left?.units.expand((e) => e).map((u) {
                              return Sp3dMaterial(
                                themeExtension.pointToColor(u.mmPoint),
                                true,
                                1,
                                themeExtension.strokeColor,
                              );
                            }) ??
                            List<Sp3dMaterial>.empty(),

                        /// Base
                        ...List.generate(SeatCushion.unitsMaxIndex, (_) {
                          return Sp3dMaterial(
                            themeExtension.baseColor,
                            true,
                            1,
                            themeExtension.strokeColor,
                          );
                        }),
                      ];
                      leftObjBuffer = Sp3dObj(
                        serialized,
                        fragments,
                        materials,
                        [],
                      );
                    }
                    world.add(
                      leftObjBuffer!,
                      Sp3dV3D(
                        LeftSeatCushion.basePosition.x,
                        LeftSeatCushion.basePosition.y,
                        0.0,
                      ),
                    );

                    final right = context.watch<RightSeatCushion?>();
                    if (rightObjBuffer != null) {
                      world.remove(rightObjBuffer!);
                    }
                    {
                      final unserialized = [
                        ...right?.units.expand((e) => e).map((u) {
                              final bottomLeft = u.blPoint;
                              final topLeft = u.tlPoint;
                              final topRight = u.trPoint;
                              final bottomRight = u.brPoint;
                              return [
                                Sp3dV3D(
                                  bottomLeft.position.x,
                                  bottomLeft.position.y,
                                  themeExtension.pointToHeight(bottomLeft),
                                ),
                                Sp3dV3D(
                                  topLeft.position.x,
                                  topLeft.position.y,
                                  themeExtension.pointToHeight(topLeft),
                                ),
                                Sp3dV3D(
                                  topRight.position.x,
                                  topRight.position.y,
                                  themeExtension.pointToHeight(topRight),
                                ),
                                Sp3dV3D(
                                  bottomRight.position.x,
                                  bottomRight.position.y,
                                  themeExtension.pointToHeight(bottomRight),
                                ),
                              ];
                            }) ??
                            List<List<Sp3dV3D>>.empty(),

                        /// Base
                        ...List.generate(SeatCushion.unitsMaxRow, (row) {
                          return List.generate(SeatCushion.unitsMaxColumn, (
                            column,
                          ) {
                            final bottomLeft =
                                SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                                  type:
                                      SeatCushionUnitCornerPointType.bottomLeft,
                                  row: row,
                                  column: column,
                                );
                            final topLeft =
                                SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                                  type: SeatCushionUnitCornerPointType.topLeft,
                                  row: row,
                                  column: column,
                                );
                            final topRight =
                                SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                                  type: SeatCushionUnitCornerPointType.topRight,
                                  row: row,
                                  column: column,
                                );
                            final bottomRight =
                                SeatCushionUnitCornerPoint.typeRowColumnToPosition(
                                  type: SeatCushionUnitCornerPointType
                                      .bottomRight,
                                  row: row,
                                  column: column,
                                );

                            return [
                              Sp3dV3D(bottomLeft.x, bottomLeft.y, 0.0),
                              Sp3dV3D(topLeft.x, topLeft.y, 0.0),
                              Sp3dV3D(topRight.x, topRight.y, 0.0),
                              Sp3dV3D(bottomRight.x, bottomRight.y, 0.0),
                            ];
                          });
                        }).expand((e) => e),
                      ];
                      final serialized = UtilSp3dList.serialize(unserialized);
                      final fragments = unserialized.indexed.map((e) {
                        final index = e.$1;
                        final face = e.$2;
                        return Sp3dFragment([
                          Sp3dFace(
                            UtilSp3dList.getIndexes(face, index * face.length),
                            index,
                          ),
                        ]);
                      }).toList();
                      final materials = [
                        ...right?.units.expand((e) => e).map((u) {
                              return Sp3dMaterial(
                                themeExtension.pointToColor(u.mmPoint),
                                true,
                                1,
                                themeExtension.strokeColor,
                              );
                            }) ??
                            List<Sp3dMaterial>.empty(),

                        /// Base
                        ...List.generate(SeatCushion.unitsMaxIndex, (_) {
                          return Sp3dMaterial(
                            themeExtension.baseColor,
                            true,
                            1,
                            themeExtension.strokeColor,
                          );
                        }),
                      ];
                      rightObjBuffer = Sp3dObj(
                        serialized,
                        fragments,
                        materials,
                        [],
                      );
                    }
                    world.add(
                      rightObjBuffer!,
                      Sp3dV3D(
                        RightSeatCushion.basePosition.x,
                        RightSeatCushion.basePosition.y,
                        0.0,
                      ),
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
                  },
                );
              },
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
