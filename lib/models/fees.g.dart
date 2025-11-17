// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fees.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeesAdapter extends TypeAdapter<Fees> {
  @override
  final typeId = 1;

  @override
  Fees read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Fees(
      feesElectricity: (fields[0] as num).toDouble(),
      feesGas: (fields[1] as num).toDouble(),
      feesWater: (fields[2] as num).toDouble(),
      utility: (fields[3] as num).toDouble(),
      reserve: (fields[4] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Fees obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.feesElectricity)
      ..writeByte(1)
      ..write(obj.feesGas)
      ..writeByte(2)
      ..write(obj.feesWater)
      ..writeByte(3)
      ..write(obj.utility)
      ..writeByte(4)
      ..write(obj.reserve);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
