// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvoiceAdapter extends TypeAdapter<Invoice> {
  @override
  final int typeId = 2;

  @override
  Invoice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Invoice(
      createdDate: fields[0] as DateTime,
      prices: fields[1] as Prices,
      fees: fields[2] as Fees,
      name: fields[3] as String,
      monthFrom: fields[4] as DateTime,
      monthTo: fields[5] as DateTime,
      electricityHigherLastMonth: (fields[6] as num).toDouble(),
      electricityHigherNewMonth: (fields[7] as num).toDouble(),
      electricityLowerLastMonth: (fields[8] as num).toDouble(),
      electricityLowerNewMonth: (fields[9] as num).toDouble(),
      gasLastMonth: (fields[10] as num).toDouble(),
      gasNewMonth: (fields[11] as num).toDouble(),
      waterLastMonth: (fields[12] as num).toDouble(),
      waterNewMonth: (fields[13] as num).toDouble(),
      totalPrice: (fields[14] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Invoice obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.createdDate)
      ..writeByte(1)
      ..write(obj.prices)
      ..writeByte(2)
      ..write(obj.fees)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.monthFrom)
      ..writeByte(5)
      ..write(obj.monthTo)
      ..writeByte(6)
      ..write(obj.electricityHigherLastMonth)
      ..writeByte(7)
      ..write(obj.electricityHigherNewMonth)
      ..writeByte(8)
      ..write(obj.electricityLowerLastMonth)
      ..writeByte(9)
      ..write(obj.electricityLowerNewMonth)
      ..writeByte(10)
      ..write(obj.gasLastMonth)
      ..writeByte(11)
      ..write(obj.gasNewMonth)
      ..writeByte(12)
      ..write(obj.waterLastMonth)
      ..writeByte(13)
      ..write(obj.waterNewMonth)
      ..writeByte(14)
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
