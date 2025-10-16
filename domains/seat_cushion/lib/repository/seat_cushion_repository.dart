part of '../seat_cushion.dart';

/// ------------------------------
/// [SeatCushionEntity]
/// ------------------------------
///
/// Represents a **data model** used by [SeatCushionRepository].
///
/// While [SeatCushion] represent the *domain object*,
/// [SeatCushionEntity] serves as the **storage or transfer layer** version of that object.
/// It defines how a [SeatCushion] is **serialized, deserialized, and persisted**.
///
/// In short:
/// - [id]: the unique identifier for each [SeatCushionEntity].
/// - [SeatCushion]: business logic / in-memory model
/// - [SeatCushionEntity]: repository-level data model for persistence or streaming
///
/// This design separates **domain logic** from **data storage**, following a clean architecture pattern.
@CopyWith()
@JsonSerializable()
class SeatCushionEntity {
  /// Unique identifier for each seat cushion entity.
  final int id;

  @JsonKey(toJson: SeatCushion._toJson)
  final SeatCushion seatCushion;

  /// Creates an immutable entity containing a unique [id] and a [seatCushion] reference.
  const SeatCushionEntity({
    required this.id,
    required this.seatCushion,
  });

  factory SeatCushionEntity.fromJson(Map<String, dynamic> json) =>
      _$SeatCushionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SeatCushionEntityToJson(this);

  static Map<String, dynamic> _toJson(SeatCushionEntity entity) =>
      entity.toJson();
}

/// ------------------------------
/// [SeatCushionRepository]
/// ------------------------------
///
/// Repository interface for managing seat cushion data.
abstract class SeatCushionRepository {
  /// Adds a new `SeatCushion` to the repository.
  Future<bool> add({
    required SeatCushion seatCushion,
  });

  /// Updates an existing entity or inserts a new one if it doesn’t exist.
  Future<bool> upsert({
    required SeatCushionEntity entity,
  });
  
  /// Retrieves the most recently added or updated entity (if any).
  SeatCushionEntity? get lastEntity;

  /// A stream that emits updates whenever `lastEntity` changes.
  Stream<SeatCushionEntity?> get lastEntityStream;

  /// Create a stream to return all of stored entities.
  Stream<SeatCushionEntity> fetchEntities();

  /// Returns the total number of stored entities.
  Future<int> fetchEntitiesLength();

  /// Removes all stored entities from the repository.
  Future<bool> clearAllEntities();

  /// Returns `true` if the repository is currently clearing all entities.
  bool get isClearingAllEntities;

  /// A stream that emits `true` or `false` when the clearing process starts or ends.
  Stream<bool> get isClearingAllEntitiesStream;
}
