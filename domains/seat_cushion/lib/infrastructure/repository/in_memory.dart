import 'dart:async';
import 'package:synchronized/synchronized.dart';

import '../../seat_cushion.dart';

class InMemorySeatCushionRepository implements SeatCushionRepository {
  final List<SeatCushionEntity> _entities = [];
  final StreamController<bool> _clearingController =
      StreamController.broadcast();
  final StreamController<SeatCushionEntity?> _lastEntityController =
      StreamController.broadcast();
  final _lock = Lock();

  bool _isClearingAllEntities = false;

  int _idCounter = -1;
  int createNewId() {
    _idCounter++;
    return _idCounter;
  }

  @override
  Future<bool> add({required SeatCushion seatCushion}) async {
    final entity = SeatCushionEntity(id: createNewId(), seatCushion: seatCushion);
    return _lock.synchronized(() {
      _entities.add(entity);
      _lastEntityController.add(entity);
      return true;
    });
  }

  @override
  Future<bool> clearAllEntities() async {
    return _lock.synchronized(() {
      _isClearingAllEntities = true;
      _clearingController.add(true);

      _entities.clear();
      _lastEntityController.add(null);

      _isClearingAllEntities = false;
      _clearingController.add(false);
      return true;
    });
  }

  @override
  Stream<SeatCushionEntity> fetchEntities() async* {
    final entities = _entities.toList();
    for (final entity in entities) {
      yield entity;
    }
  }

  @override
  Future<int> fetchEntitiesLength() async {
    return _entities.length;
  }

  @override
  bool get isClearingAllEntities => _isClearingAllEntities;

  @override
  Stream<bool> get isClearingAllEntitiesStream =>
      _clearingController.stream.asBroadcastStream();

  @override
  SeatCushionEntity? get lastEntity =>
      _entities.isEmpty ? null : _entities.last;

  @override
  Stream<SeatCushionEntity?> get lastEntityStream =>
      _lastEntityController.stream.asBroadcastStream();

  @override
  Future<bool> upsert({required SeatCushionEntity entity}) async {
    return _lock.synchronized(() {
      final index = _entities.indexWhere((e) => e.id == entity.id);
      if (index >= 0) {
        _entities[index] = entity;
      } else {
        _entities.add(entity);
      }
      _lastEntityController.add(entity);
      return true;
    });
  }

  void dispose() {
    _clearingController.close();
    _lastEntityController.close();
  }
}
