part of '../ad5940.dart';

enum Ad5940CommandMain {
  reboot,
  stop,
  start,
  write,
}

enum Ad5940CommandWriteType {
  ad5940Aferef,
  ad5940Lploop,
  ad5940Hsloop,
  ad5940Dsp,
  delay,
  electrochemicalCa,
  electrochemicalCv,
  electrochemicalDpv,
  isCyclic,
}

@CopyWith()
@JsonSerializable()
class Ad5940Command with EquatableMixin {
  final Ad5940CommandMain main;

  Ad5940Command({
    required this.main,
  });
  
  @mustCallSuper
  List<int> get bytes => [
    main.index,
  ];

  @override
  List<Object?> get props => [
    bytes,
  ];

  factory Ad5940Command.fromJson(Map<String, dynamic> json) =>
      _$Ad5940CommandFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$Ad5940CommandToJson(this);

  static Map<String, dynamic> _toJson(Ad5940Command seatCushion) =>
      seatCushion.toJson();
}