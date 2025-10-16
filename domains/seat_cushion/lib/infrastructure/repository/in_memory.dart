import 'dart:async';
import 'package:synchronized/synchronized.dart';

import '../../seat_cushion.dart';

/// --------------------------------------------
/// [InMemorySeatCushionRepository]
/// --------------------------------------------
///
/// A simple **in-memory implementation** of [SeatCushionRepository].
///
/// Thread-safety is ensured through the use of [Lock] from the
/// `synchronized` package, preventing concurrent modification
/// of the in-memory list.
class InMemorySeatCushionRepository implements SeatCushionRepository {
  /// Internal list storing all cushion entities in memory.
  final List<SeatCushionEntity> _entities = [];

  /// Controller that emits events when clearing operations occur.
  final StreamController<bool> _clearingController =
      StreamController.broadcast();

  /// Controller that emits the latest [SeatCushionEntity].
  final StreamController<SeatCushionEntity?> _lastEntityController =
      StreamController.broadcast();

  /// Synchronization lock to ensure thread-safe operations.
  final _lock = Lock();

  /// Tracks whether a clear-all operation is currently running.
  bool _isClearingAllEntities = false;

  /// Auto-incrementing ID counter for new entities.
  int _idCounter = -1;

  /// Generates a new incremental ID for a newly added entity.
  int createNewId() {
    _idCounter++;
    return _idCounter;
  }

  /// --------------------------------------------
  /// Repository Implementation
  /// --------------------------------------------

  /// Adds a new [SeatCushion] as an entity to the repository.
  ///
  /// Emits the newly added entity to [lastEntityStream].
  @override
  Future<bool> add({required SeatCushion seatCushion}) async {
    final entity = SeatCushionEntity(
      id: createNewId(),
      seatCushion: seatCushion,
    );
    return _lock.synchronized(() {
      _entities.add(entity);
      _lastEntityController.add(entity);
      return true;
    });
  }

  /// Removes all entities from memory.
  ///
  /// Emits `true` to [isClearingAllEntitiesStream] at the start of the operation
  /// and `false` upon completion.
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

  /// Returns a stream of all entities currently stored in memory.
  ///
  /// This is a one-time emission stream — it does not update
  /// automatically when new entities are added.
  @override
  Stream<SeatCushionEntity> fetchEntities() async* {
    final entities = _entities.toList();
    for (final entity in entities) {
      yield entity;
    }
  }

  /// Returns the total number of stored entities.
  @override
  Future<int> fetchEntitiesLength() async {
    return _entities.length;
  }

  /// Whether the repository is currently performing a clear operation.
  @override
  bool get isClearingAllEntities => _isClearingAllEntities;

  /// Emits the current clearing state (`true` = in progress, `false` = idle).
  @override
  Stream<bool> get isClearingAllEntitiesStream =>
      _clearingController.stream.asBroadcastStream();

  /// Returns the most recently added or updated [SeatCushionEntity].
  @override
  SeatCushionEntity? get lastEntity =>
      _entities.isEmpty ? null : _entities.last;

  /// Emits updates whenever the last stored entity changes.
  @override
  Stream<SeatCushionEntity?> get lastEntityStream =>
      _lastEntityController.stream.asBroadcastStream();

  /// Updates an existing [SeatCushionEntity] or inserts it if it does not exist.
  ///
  /// Emits the upserted entity to [lastEntityStream].
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

  /// Closes all internal stream controllers.
  ///
  /// Call this method when disposing of the repository
  /// to release all in-memory resources.
  void dispose() {
    _clearingController.close();
    _lastEntityController.close();
  }
}
