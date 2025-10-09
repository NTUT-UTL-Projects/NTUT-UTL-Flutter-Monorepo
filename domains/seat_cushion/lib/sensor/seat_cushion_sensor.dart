part of '../seat_cushion.dart';

abstract class SeatCushionSensor {
  Stream<LeftSeatCushion> get leftStream;
  Stream<RightSeatCushion> get rightStream;
  Stream<SeatCushionSet> get setStream;
  Stream<SeatCushion> get stream;
}
