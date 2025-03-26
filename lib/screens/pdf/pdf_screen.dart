import 'dart:math';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../models/invoice.dart';
import 'widgets/pdf_consumption.dart';

class PdfScreen extends StatelessWidget {
  final Invoice invoice;
  final MemoryImage backIcon;
  final Font font400;
  final Font font600;
  final Font font700;

  PdfScreen({
    required this.invoice,
    required this.backIcon,
    required this.font400,
    required this.font600,
    required this.font700,
  });

  /// Calculates invoice
  double? calculateInvoice() {
    /// Electricity higher
    final electricityHigherDifference = invoice.electricityHigherNewMonth - invoice.electricityHigherLastMonth;

    /// Electricity lower
    final electricityLowerDifference = invoice.electricityLowerNewMonth - invoice.electricityLowerLastMonth;

    /// Gas
    final gasDifference = invoice.gasNewMonth - invoice.gasLastMonth;

    /// Water
    final waterDifference = invoice.waterNewMonth - invoice.waterLastMonth;

    /// Prices
    final prices = invoice.prices;

    /// Calculate `sum`
    final sum = double.tryParse(
      ((gasDifference * prices.gasPrice) +
              (electricityHigherDifference * prices.electricityHigherPrice) +
              (electricityLowerDifference * prices.electricityLowerPrice) +
              (waterDifference * prices.waterPrice) +
              invoice.fees.feesGas +
              invoice.fees.feesElectricity +
              invoice.fees.feesWater +
              invoice.fees.utility +
              invoice.fees.reserve)
          .toStringAsFixed(2),
    );

    return sum;
  }

  @override
  Widget build(Context context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///
          /// TITLE
          ///
          Text(
            invoice.name,
            style: TextStyle(
              font: font700,
              fontSize: 26,
            ),
          ),
          SizedBox(height: 24),

          ///
          /// MONTH
          ///
          Text(
            'Režije za mjesec',
            style: TextStyle(
              font: font400,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 4),
          Text(
            DateFormat(
              'd. MMMM y.',
              'hr',
            ).format(invoice.monthFrom),
            style: TextStyle(
              font: font600,
              fontSize: 18,
            ),
          ),
          Text(
            DateFormat(
              'd. MMMM y.',
              'hr',
            ).format(invoice.monthTo),
            style: TextStyle(
              font: font600,
              fontSize: 18,
            ),
          ),

          ///
          /// DIVIDER
          ///
          SizedBox(height: 24),
          Container(
            height: 2.5,
            width: double.infinity,
            color: PdfColor.fromHex('#000000'),
          ),
          SizedBox(height: 8),

          ///
          /// TITLE
          ///
          Text(
            'Potrošnja',
            style: TextStyle(
              font: font700,
              fontSize: 28,
            ),
          ),
          SizedBox(height: 20),

          ///
          /// EXPLANATION
          ///
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Staro stanje',
                  style: TextStyle(
                    font: font400,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Novo stanje',
                  style: TextStyle(
                    font: font400,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Cijena',
                  style: TextStyle(
                    font: font400,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Zbroj',
                  style: TextStyle(
                    font: font600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          ///
          /// ELECTRICITY HIGHER
          ///
          PdfConsumption(
            title: 'Struja',
            oldValue: invoice.electricityHigherLastMonth,
            newValue: invoice.electricityHigherNewMonth,
            price: invoice.prices.electricityHigherPrice,
            totalPrice: (invoice.electricityHigherNewMonth - invoice.electricityHigherLastMonth) * invoice.prices.electricityHigherPrice,
            icon: Transform.rotate(
              angle: pi * 1.5,
              child: Image(
                backIcon,
                height: 20,
                width: 20,
              ),
            ),
            font400: font400,
            font600: font600,
            font700: font700,
          ),
          SizedBox(height: 16),

          ///
          /// ELECTRICITY LOWER
          ///
          PdfConsumption(
            title: 'Struja',
            oldValue: invoice.electricityLowerLastMonth,
            newValue: invoice.electricityLowerNewMonth,
            price: invoice.prices.electricityLowerPrice,
            totalPrice: (invoice.electricityLowerNewMonth - invoice.electricityLowerLastMonth) * invoice.prices.electricityLowerPrice,
            icon: Transform.rotate(
              angle: pi / 2,
              child: Image(
                backIcon,
                height: 20,
                width: 20,
              ),
            ),
            font400: font400,
            font600: font600,
            font700: font700,
          ),
          SizedBox(height: 16),

          ///
          /// GAS
          ///
          PdfConsumption(
            title: 'Plin',
            oldValue: invoice.gasLastMonth,
            newValue: invoice.gasNewMonth,
            price: invoice.prices.gasPrice,
            totalPrice: (invoice.gasNewMonth - invoice.gasLastMonth) * invoice.prices.gasPrice,
            font400: font400,
            font600: font600,
            font700: font700,
          ),
          SizedBox(height: 16),

          ///
          /// WATER
          ///
          PdfConsumption(
            title: 'Voda',
            oldValue: invoice.waterLastMonth,
            newValue: invoice.waterNewMonth,
            price: invoice.prices.waterPrice,
            totalPrice: (invoice.waterNewMonth - invoice.waterLastMonth) * invoice.prices.waterPrice,
            font400: font400,
            font600: font600,
            font700: font700,
          ),

          ///
          /// DIVIDER
          ///
          SizedBox(height: 24),
          Container(
            height: 2.5,
            width: double.infinity,
            color: PdfColor.fromHex('#000000'),
          ),
          SizedBox(height: 8),

          ///
          /// TITLE
          ///
          Text(
            'Naknade',
            style: TextStyle(
              font: font700,
              fontSize: 28,
            ),
          ),
          SizedBox(height: 20),

          ///
          /// FEES
          ///
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Struja',
                  style: TextStyle(
                    font: font700,
                    fontSize: 22,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '${invoice.fees.feesElectricity.toStringAsFixed(2)}€',
                  style: TextStyle(
                    font: font600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Plin',
                  style: TextStyle(
                    font: font700,
                    fontSize: 22,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '${invoice.fees.feesGas.toStringAsFixed(2)}€',
                  style: TextStyle(
                    font: font600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Voda',
                  style: TextStyle(
                    font: font700,
                    fontSize: 22,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '${invoice.fees.feesWater.toStringAsFixed(2)}€',
                  style: TextStyle(
                    font: font600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          ///
          /// UTILITY
          ///
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Komunalna naknada',
                  style: TextStyle(
                    font: font700,
                    fontSize: 22,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '${invoice.fees.utility.toStringAsFixed(2)}€',
                  style: TextStyle(
                    font: font600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          ///
          /// RESERVE
          ///
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Pričuva',
                  style: TextStyle(
                    font: font700,
                    fontSize: 22,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '${invoice.fees.reserve.toStringAsFixed(2)}€',
                  style: TextStyle(
                    font: font600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),

          ///
          /// DIVIDER
          ///
          SizedBox(height: 24),
          Container(
            height: 2.5,
            width: double.infinity,
            color: PdfColor.fromHex('#000000'),
          ),
          SizedBox(height: 24),

          ///
          /// TOTAL
          ///
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Ukupno',
                  style: TextStyle(
                    font: font700,
                    fontSize: 26,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '${calculateInvoice()}€',
                  style: TextStyle(
                    font: font600,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      );
}
