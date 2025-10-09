part of '../seat_cushion.dart';

@CopyWith()
@JsonSerializable()
class SeatCushionEntity {
  final int id;
  
  @JsonKey(toJson: SeatCushion._toJson)
  final SeatCushion seatCushion;

  const SeatCushionEntity({
    required this.id,
    required this.seatCushion,
  });

  factory SeatCushionEntity.fromJson(Map<String, dynamic> json) => _$SeatCushionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SeatCushionEntityToJson(this);

  static Map<String, dynamic> _toJson(SeatCushionEntity entity) => entity.toJson();

}

/// Repository interface for managing seat cushion data
abstract class SeatCushionRepository {
  Future<bool> add({
    required SeatCushion seatCushion,
  });
  Future<bool> upsert({
    required SeatCushionEntity entity,
  });
  
  SeatCushionEntity? get lastEntity;
  Stream<SeatCushionEntity?> get lastEntityStream;

  Stream<SeatCushionEntity> fetchEntities();
  Future<int> fetchEntitiesLength();

  Future<bool> clearAllEntities();
  bool get isClearingAllEntities;
  Stream<bool> get isClearingAllEntitiesStream;
}
