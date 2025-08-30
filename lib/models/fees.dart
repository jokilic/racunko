import 'package:hive_ce_flutter/hive_flutter.dart';

part 'fees.g.dart';

@HiveType(typeId: 1)
class Fees {
  @HiveField(0)
  final double feesElectricity;
  @HiveField(1)
  final double feesGas;
  @HiveField(2)
  final double feesWater;
  @HiveField(3)
  final double utility;
  @HiveField(4)
  final double reserve;

  Fees({
    required this.feesElectricity,
    required this.feesGas,
    required this.feesWater,
    required this.utility,
    required this.reserve,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
    'feesElectricity': feesElectricity,
    'feesGas': feesGas,
    'feesWater': feesWater,
    'utility': utility,
    'reserve': reserve,
  };

  factory Fees.fromMap(Map<String, dynamic> map) => Fees(
    feesElectricity: (map['feesElectricity'] as num).toDouble(),
    feesGas: (map['feesGas'] as num).toDouble(),
    feesWater: (map['feesWater'] as num).toDouble(),
    utility: (map['utility'] as num).toDouble(),
    reserve: (map['reserve'] as num).toDouble(),
  );

  @override
  String toString() => 'Fees(feesElectricity: $feesElectricity, feesGas: $feesGas, feesWater: $feesWater, utility: $utility, reserve: $reserve)';

  @override
  bool operator ==(covariant Fees other) {
    if (identical(this, other)) {
      return true;
    }

    return other.feesElectricity == feesElectricity && other.feesGas == feesGas && other.feesWater == feesWater && other.utility == utility && other.reserve == reserve;
  }

  @override
  int get hashCode => feesElectricity.hashCode ^ feesGas.hashCode ^ feesWater.hashCode ^ utility.hashCode ^ reserve.hashCode;
}
