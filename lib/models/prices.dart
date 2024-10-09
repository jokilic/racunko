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
