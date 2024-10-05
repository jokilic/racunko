// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prices.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PricesAdapter extends TypeAdapter<Prices> {
  @override
  final int typeId = 0;

  @override
  Prices read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Prices(
      electricityHigherPrice: (fields[0] as num).toDouble(),
      electricityLowerPrice: (fields[1] as num).toDouble(),
      gasPrice: (fields[2] as num).toDouble(),
      waterPrice: (fields[3] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Prices obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.electricityHigherPrice)
      ..writeByte(1)
      ..write(obj.electricityLowerPrice)
      ..writeByte(2)
      ..write(obj.gasPrice)
      ..writeByte(3)
      ..write(obj.waterPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PricesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
