import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'fees.dart';
import 'prices.dart';

part 'invoice.g.dart';

@HiveType(typeId: 2)
class Invoice {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final DateTime createdDate;
  @HiveField(2)
  final Prices prices;
  @HiveField(3)
  final Fees fees;
  @HiveField(4)
  final String name;
  @HiveField(5)
  final DateTime monthFrom;
  @HiveField(6)
  final DateTime monthTo;
  @HiveField(7)
  final double electricityHigherLastMonth;
  @HiveField(8)
  final double electricityHigherNewMonth;
  @HiveField(9)
  final double electricityLowerLastMonth;
  @HiveField(10)
  final double electricityLowerNewMonth;
  @HiveField(11)
  final double gasLastMonth;
  @HiveField(12)
  final double gasNewMonth;
  @HiveField(13)
  final double waterLastMonth;
  @HiveField(14)
  final double waterNewMonth;
  @HiveField(15)
  final double totalPrice;

  Invoice({
    required this.id,
    required this.createdDate,
    required this.prices,
    required this.fees,
    required this.name,
    required this.monthFrom,
    required this.monthTo,
    required this.electricityHigherLastMonth,
    required this.electricityHigherNewMonth,
    required this.electricityLowerLastMonth,
    required this.electricityLowerNewMonth,
    required this.gasLastMonth,
    required this.gasNewMonth,
    required this.waterLastMonth,
    required this.waterNewMonth,
    required this.totalPrice,
  });

  factory Invoice.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Invoice.fromMap(data);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'createdDate': Timestamp.fromDate(createdDate),
        'prices': prices.toMap(),
        'fees': fees.toMap(),
        'name': name,
        'monthFrom': Timestamp.fromDate(monthFrom),
        'monthTo': Timestamp.fromDate(monthTo),
        'electricityHigherLastMonth': electricityHigherLastMonth,
        'electricityHigherNewMonth': electricityHigherNewMonth,
        'electricityLowerLastMonth': electricityLowerLastMonth,
        'electricityLowerNewMonth': electricityLowerNewMonth,
        'gasLastMonth': gasLastMonth,
        'gasNewMonth': gasNewMonth,
        'waterLastMonth': waterLastMonth,
        'waterNewMonth': waterNewMonth,
        'totalPrice': totalPrice,
      };

  factory Invoice.fromMap(Map<String, dynamic> map) => Invoice(
        id: map['id'] as String,
        createdDate: (map['createdDate'] as Timestamp).toDate(),
        prices: Prices.fromMap(map['prices'] as Map<String, dynamic>),
        fees: Fees.fromMap(map['fees'] as Map<String, dynamic>),
        name: map['name'] as String,
        monthFrom: (map['monthFrom'] as Timestamp).toDate(),
        monthTo: (map['monthTo'] as Timestamp).toDate(),
        electricityHigherLastMonth: map['electricityHigherLastMonth'] as double,
        electricityHigherNewMonth: map['electricityHigherNewMonth'] as double,
        electricityLowerLastMonth: map['electricityLowerLastMonth'] as double,
        electricityLowerNewMonth: map['electricityLowerNewMonth'] as double,
        gasLastMonth: map['gasLastMonth'] as double,
        gasNewMonth: map['gasNewMonth'] as double,
        waterLastMonth: map['waterLastMonth'] as double,
        waterNewMonth: map['waterNewMonth'] as double,
        totalPrice: map['totalPrice'] as double,
      );

  @override
  String toString() =>
      'Invoice(id: $id, createdDate: $createdDate, prices: $prices, fees: $fees, name: $name, monthFrom: $monthFrom, monthTo: $monthTo, electricityHigherLastMonth: $electricityHigherLastMonth, electricityHigherNewMonth: $electricityHigherNewMonth, electricityLowerLastMonth: $electricityLowerLastMonth, electricityLowerNewMonth: $electricityLowerNewMonth, gasLastMonth: $gasLastMonth, gasNewMonth: $gasNewMonth, waterLastMonth: $waterLastMonth, waterNewMonth: $waterNewMonth, totalPrice: $totalPrice)';

  @override
  bool operator ==(covariant Invoice other) {
    if (identical(this, other)) {
      return true;
    }

    return other.id == id &&
        other.createdDate == createdDate &&
        other.prices == prices &&
        other.fees == fees &&
        other.name == name &&
        other.monthFrom == monthFrom &&
        other.monthTo == monthTo &&
        other.electricityHigherLastMonth == electricityHigherLastMonth &&
        other.electricityHigherNewMonth == electricityHigherNewMonth &&
        other.electricityLowerLastMonth == electricityLowerLastMonth &&
        other.electricityLowerNewMonth == electricityLowerNewMonth &&
        other.gasLastMonth == gasLastMonth &&
        other.gasNewMonth == gasNewMonth &&
        other.waterLastMonth == waterLastMonth &&
        other.waterNewMonth == waterNewMonth &&
        other.totalPrice == totalPrice;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      createdDate.hashCode ^
      prices.hashCode ^
      fees.hashCode ^
      name.hashCode ^
      monthFrom.hashCode ^
      monthTo.hashCode ^
      electricityHigherLastMonth.hashCode ^
      electricityHigherNewMonth.hashCode ^
      electricityLowerLastMonth.hashCode ^
      electricityLowerNewMonth.hashCode ^
      gasLastMonth.hashCode ^
      gasNewMonth.hashCode ^
      waterLastMonth.hashCode ^
      waterNewMonth.hashCode ^
      totalPrice.hashCode;
}
