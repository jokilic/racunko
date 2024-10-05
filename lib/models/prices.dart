import 'dart:convert';

import 'package:hive_ce_flutter/hive_flutter.dart';

part 'prices.g.dart';

@HiveType(typeId: 0)
class Prices {
  @HiveField(0)
  final double electricityHigherPrice;
  @HiveField(1)
  final double electricityLowerPrice;
  @HiveField(2)
  final double gasPrice;
  @HiveField(3)
  final double waterPrice;

  Prices({
    required this.electricityHigherPrice,
    required this.electricityLowerPrice,
    required this.gasPrice,
    required this.waterPrice,
  });

  Prices copyWith({
    double? electricityHigherPrice,
    double? electricityLowerPrice,
    double? gasPrice,
    double? waterPrice,
  }) =>
      Prices(
        electricityHigherPrice: electricityHigherPrice ?? this.electricityHigherPrice,
        electricityLowerPrice: electricityLowerPrice ?? this.electricityLowerPrice,
        gasPrice: gasPrice ?? this.gasPrice,
        waterPrice: waterPrice ?? this.waterPrice,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'electricityHigherPrice': electricityHigherPrice,
        'electricityLowerPrice': electricityLowerPrice,
        'gasPrice': gasPrice,
        'waterPrice': waterPrice,
      };

  factory Prices.fromMap(Map<String, dynamic> map) => Prices(
        electricityHigherPrice: map['electricityHigherPrice'] as double,
        electricityLowerPrice: map['electricityLowerPrice'] as double,
        gasPrice: map['gasPrice'] as double,
        waterPrice: map['waterPrice'] as double,
      );

  String toJson() => json.encode(toMap());

  factory Prices.fromJson(String source) => Prices.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Prices(electricityHigherPrice: $electricityHigherPrice, electricityLowerPrice: $electricityLowerPrice, gasPrice: $gasPrice, waterPrice: $waterPrice)';

  @override
  bool operator ==(covariant Prices other) {
    if (identical(this, other)) {
      return true;
    }

    return other.electricityHigherPrice == electricityHigherPrice &&
        other.electricityLowerPrice == electricityLowerPrice &&
        other.gasPrice == gasPrice &&
        other.waterPrice == waterPrice;
  }

  @override
  int get hashCode => electricityHigherPrice.hashCode ^ electricityLowerPrice.hashCode ^ gasPrice.hashCode ^ waterPrice.hashCode;
}
