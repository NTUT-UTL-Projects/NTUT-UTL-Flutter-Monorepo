// Copyright 2024-2025, Zhen-Xiang Chen.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Seat cushion data decoder template.
library;

import 'dart:async';

import '../../seat_cushion.dart';

abstract class SeatCushionSensorDecoder {
  // LeftSeatCushion stream
  Stream<LeftSeatCushion> get leftStream;

  // RightSeatCushion stream
  Stream<RightSeatCushion> get rightStream;

  // Add the values to the buffer​ ​and then send the seat
  // cushion data via stream when the conditions are met.
  Future<void> addValues(List<int> values);
  
}
