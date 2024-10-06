import 'dart:convert';

import 'package:hive_ce_flutter/hive_flutter.dart';

import 'fees.dart';
import 'prices.dart';

part 'invoice.g.dart';

@HiveType(typeId: 2)
class Invoice {
  @HiveField(0)
  final DateTime createdDate;
  @HiveField(1)
  final Prices prices;
  @HiveField(2)
  final Fees fees;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final DateTime monthFrom;
  @HiveField(5)
  final DateTime monthTo;
  @HiveField(6)
  final double electricityHigherLastMonth;
  @HiveField(7)
  final double electricityHigherNewMonth;
  @HiveField(8)
  final double electricityLowerLastMonth;
  @HiveField(9)
  final double electricityLowerNewMonth;
  @HiveField(10)
  final double gasLastMonth;
  @HiveField(11)
  final double gasNewMonth;
  @HiveField(12)
  final double waterLastMonth;
  @HiveField(13)
  final double waterNewMonth;
  @HiveField(14)
  final double totalPrice;

  Invoice({
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

  Invoice copyWith({
    DateTime? createdDate,
    Prices? prices,
    Fees? fees,
    String? name,
    DateTime? monthFrom,
    DateTime? monthTo,
    double? electricityHigherLastMonth,
    double? electricityHigherNewMonth,
    double? electricityLowerLastMonth,
    double? electricityLowerNewMonth,
    double? gasLastMonth,
    double? gasNewMonth,
    double? waterLastMonth,
    double? waterNewMonth,
    double? totalPrice,
  }) =>
      Invoice(
        createdDate: createdDate ?? this.createdDate,
        prices: prices ?? this.prices,
        fees: fees ?? this.fees,
        name: name ?? this.name,
        monthFrom: monthFrom ?? this.monthFrom,
        monthTo: monthTo ?? this.monthTo,
        electricityHigherLastMonth: electricityHigherLastMonth ?? this.electricityHigherLastMonth,
        electricityHigherNewMonth: electricityHigherNewMonth ?? this.electricityHigherNewMonth,
        electricityLowerLastMonth: electricityLowerLastMonth ?? this.electricityLowerLastMonth,
        electricityLowerNewMonth: electricityLowerNewMonth ?? this.electricityLowerNewMonth,
        gasLastMonth: gasLastMonth ?? this.gasLastMonth,
        gasNewMonth: gasNewMonth ?? this.gasNewMonth,
        waterLastMonth: waterLastMonth ?? this.waterLastMonth,
        waterNewMonth: waterNewMonth ?? this.waterNewMonth,
        totalPrice: totalPrice ?? this.totalPrice,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'createdDate': createdDate.millisecondsSinceEpoch,
        'prices': prices.toMap(),
        'fees': fees.toMap(),
        'name': name,
        'monthFrom': monthFrom.millisecondsSinceEpoch,
        'monthTo': monthTo.millisecondsSinceEpoch,
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
        createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int),
        prices: Prices.fromMap(map['prices'] as Map<String, dynamic>),
        fees: Fees.fromMap(map['fees'] as Map<String, dynamic>),
        name: map['name'] as String,
        monthFrom: DateTime.fromMillisecondsSinceEpoch(map['monthFrom'] as int),
        monthTo: DateTime.fromMillisecondsSinceEpoch(map['monthTo'] as int),
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

  String toJson() => json.encode(toMap());

  factory Invoice.fromJson(String source) => Invoice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Invoice(createdDate: $createdDate, prices: $prices, fees: $fees, name: $name, monthFrom: $monthFrom, monthTo: $monthTo, electricityHigherLastMonth: $electricityHigherLastMonth, electricityHigherNewMonth: $electricityHigherNewMonth, electricityLowerLastMonth: $electricityLowerLastMonth, electricityLowerNewMonth: $electricityLowerNewMonth, gasLastMonth: $gasLastMonth, gasNewMonth: $gasNewMonth, waterLastMonth: $waterLastMonth, waterNewMonth: $waterNewMonth, totalPrice: $totalPrice)';

  @override
  bool operator ==(covariant Invoice other) {
    if (identical(this, other)) {
      return true;
    }

    return other.createdDate == createdDate &&
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
