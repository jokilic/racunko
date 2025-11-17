// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvoiceAdapter extends TypeAdapter<Invoice> {
  @override
  final typeId = 2;

  @override
  Invoice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Invoice(
      id: fields[0] as String,
      createdDate: fields[1] as DateTime,
      prices: fields[2] as Prices,
      fees: fields[3] as Fees,
      name: fields[4] as String,
      monthFrom: fields[5] as DateTime,
      monthTo: fields[6] as DateTime,
      electricityHigherLastMonth: (fields[7] as num).toDouble(),
      electricityHigherNewMonth: (fields[8] as num).toDouble(),
      electricityLowerLastMonth: (fields[9] as num).toDouble(),
      electricityLowerNewMonth: (fields[10] as num).toDouble(),
      gasLastMonth: (fields[11] as num).toDouble(),
      gasNewMonth: (fields[12] as num).toDouble(),
      waterLastMonth: (fields[13] as num).toDouble(),
      waterNewMonth: (fields[14] as num).toDouble(),
      totalPrice: (fields[15] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Invoice obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdDate)
      ..writeByte(2)
      ..write(obj.prices)
      ..writeByte(3)
      ..write(obj.fees)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.monthFrom)
      ..writeByte(6)
      ..write(obj.monthTo)
      ..writeByte(7)
      ..write(obj.electricityHigherLastMonth)
      ..writeByte(8)
      ..write(obj.electricityHigherNewMonth)
      ..writeByte(9)
      ..write(obj.electricityLowerLastMonth)
      ..writeByte(10)
      ..write(obj.electricityLowerNewMonth)
      ..writeByte(11)
      ..write(obj.gasLastMonth)
      ..writeByte(12)
      ..write(obj.gasNewMonth)
      ..writeByte(13)
      ..write(obj.waterLastMonth)
      ..writeByte(14)
      ..write(obj.waterNewMonth)
      ..writeByte(15)
      ..write(obj.totalPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
