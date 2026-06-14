import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../models/invoice.dart';

class PdfScreen extends StatelessWidget {
  final Invoice invoice;
  final Font font400;
  final Font font600;
  final Font font700;

  PdfScreen({
    required this.invoice,
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

  double calculateElectricityHigherTotal() => (invoice.electricityHigherNewMonth - invoice.electricityHigherLastMonth) * invoice.prices.electricityHigherPrice;

  double calculateElectricityLowerTotal() => (invoice.electricityLowerNewMonth - invoice.electricityLowerLastMonth) * invoice.prices.electricityLowerPrice;

  double calculateGasTotal() => (invoice.gasNewMonth - invoice.gasLastMonth) * invoice.prices.gasPrice;

  double calculateWaterTotal() => (invoice.waterNewMonth - invoice.waterLastMonth) * invoice.prices.waterPrice;

  double calculateElectricitySectionTotal() => calculateElectricityHigherTotal() + calculateElectricityLowerTotal() + invoice.fees.feesElectricity;

  double calculateGasSectionTotal() => calculateGasTotal() + invoice.fees.feesGas;

  double calculateWaterSectionTotal() => calculateWaterTotal() + invoice.fees.feesWater;

  String formatNumber(double value) => NumberFormat('0.##', 'hr').format(value);

  String formatMoney(double value) => '${NumberFormat('0.00', 'hr').format(value)}€';

  Widget buildDivider() => Container(
    height: 2.5,
    width: double.infinity,
    color: PdfColor.fromHex('#000000'),
  );

  Widget buildCell(
    String text, {
    int flex = 1,
    Font? font,
    double fontSize = 14,
    TextAlign textAlign = TextAlign.center,
  }) => Expanded(
    flex: flex,
    child: Text(
      text,
      style: TextStyle(
        font: font ?? font400,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
    ),
  );

  Widget buildTableRow({
    required String title,
    required String amount,
    String unit = '',
    String oldValue = '',
    String newValue = '',
    String difference = '',
    String price = '',
    Font? titleFont,
    Font? amountFont,
    double titleSize = 16,
    double amountSize = 16,
  }) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCell(
          title,
          flex: 3,
          font: titleFont ?? font600,
          fontSize: titleSize,
          textAlign: TextAlign.left,
        ),
        buildCell(unit),
        buildCell(oldValue),
        buildCell(newValue),
        buildCell(difference),
        buildCell(price),
        buildCell(
          amount,
          font: amountFont ?? font600,
          fontSize: amountSize,
          textAlign: TextAlign.right,
        ),
      ],
    ),
  );

  Widget buildTotalRow({
    required String title,
    required String amount,
  }) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              font: font700,
              fontSize: 24,
            ),
          ),
        ),
        Expanded(
          child: Text(
            amount,
            style: TextStyle(
              font: font700,
              fontSize: 24,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );

  Widget buildHeaderRow() => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        buildCell('', flex: 3),
        buildCell('Jedinica', fontSize: 12),
        buildCell('Staro stanje', fontSize: 12),
        buildCell('Novo stanje', fontSize: 12),
        buildCell('Razlika', fontSize: 12),
        buildCell('Cijena', fontSize: 12),
        buildCell(
          'Iznos',
          font: font600,
          fontSize: 12,
          textAlign: TextAlign.right,
        ),
      ],
    ),
  );

  Widget buildSectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      title,
      style: TextStyle(
        font: font600,
        fontSize: 20,
      ),
    ),
  );

  Widget buildElectricitySection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('Struja'),
      buildTableRow(
        title: 'Viša tarifa',
        unit: 'kWh',
        oldValue: formatNumber(
          invoice.electricityHigherLastMonth,
        ),
        newValue: formatNumber(
          invoice.electricityHigherNewMonth,
        ),
        difference: formatNumber(
          invoice.electricityHigherNewMonth - invoice.electricityHigherLastMonth,
        ),
        price: formatMoney(
          invoice.prices.electricityHigherPrice,
        ),
        amount: formatMoney(
          calculateElectricityHigherTotal(),
        ),
        titleFont: font400,
        amountFont: font400,
      ),
      buildTableRow(
        title: 'Niža tarifa',
        unit: 'kWh',
        oldValue: formatNumber(
          invoice.electricityLowerLastMonth,
        ),
        newValue: formatNumber(
          invoice.electricityLowerNewMonth,
        ),
        difference: formatNumber(
          invoice.electricityLowerNewMonth - invoice.electricityLowerLastMonth,
        ),
        price: formatMoney(
          invoice.prices.electricityLowerPrice,
        ),
        amount: formatMoney(
          calculateElectricityLowerTotal(),
        ),
        titleFont: font400,
        amountFont: font400,
      ),
      buildTableRow(
        title: 'Naknada',
        amount: formatMoney(
          invoice.fees.feesElectricity,
        ),
        titleFont: font400,
        amountFont: font400,
      ),
      buildTableRow(
        title: 'Ukupno',
        amount: formatMoney(
          calculateElectricitySectionTotal(),
        ),
        titleFont: font600,
        amountFont: font600,
      ),
    ],
  );

  Widget buildGasSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('Plin'),
      buildTableRow(
        title: 'Stanje',
        unit: 'm3',
        oldValue: formatNumber(
          invoice.gasLastMonth,
        ),
        newValue: formatNumber(
          invoice.gasNewMonth,
        ),
        difference: formatNumber(
          invoice.gasNewMonth - invoice.gasLastMonth,
        ),
        price: formatMoney(
          invoice.prices.gasPrice,
        ),
        amount: formatMoney(
          calculateGasTotal(),
        ),
        titleFont: font400,
        amountFont: font400,
      ),
      buildTableRow(
        title: 'Naknada',
        amount: formatMoney(
          invoice.fees.feesGas,
        ),
        titleFont: font400,
        amountFont: font400,
      ),
      buildTableRow(
        title: 'Ukupno',
        amount: formatMoney(
          calculateGasSectionTotal(),
        ),
        titleFont: font600,
        amountFont: font600,
      ),
    ],
  );

  Widget buildWaterSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('Voda'),
      buildTableRow(
        title: 'Stanje',
        unit: 'm3',
        oldValue: formatNumber(
          invoice.waterLastMonth,
        ),
        newValue: formatNumber(
          invoice.waterNewMonth,
        ),
        difference: formatNumber(
          invoice.waterNewMonth - invoice.waterLastMonth,
        ),
        price: formatMoney(
          invoice.prices.waterPrice,
        ),
        amount: formatMoney(
          calculateWaterTotal(),
        ),
        titleFont: font400,
        amountFont: font400,
      ),
      buildTableRow(
        title: 'Naknada',
        amount: formatMoney(
          invoice.fees.feesWater,
        ),
        titleFont: font400,
        amountFont: font400,
      ),
      buildTableRow(
        title: 'Ukupno',
        amount: formatMoney(
          calculateWaterSectionTotal(),
        ),
        titleFont: font600,
        amountFont: font600,
      ),
    ],
  );

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
          fontSize: 24,
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
      SizedBox(height: 20),
      buildDivider(),
      SizedBox(height: 18),

      ///
      /// LEGEND
      ///
      buildHeaderRow(),

      ///
      /// ELECTRICITY
      ///
      buildElectricitySection(),
      SizedBox(height: 8),

      ///
      /// GAS
      ///
      buildGasSection(),
      SizedBox(height: 8),

      ///
      /// Water
      ///
      buildWaterSection(),

      ///
      /// DIVIDER
      ///
      SizedBox(height: 20),
      buildDivider(),
      SizedBox(height: 14),

      ///
      /// UTILITY
      ///
      buildTableRow(
        title: 'Komunalna naknada',
        amount: formatMoney(
          invoice.fees.utility,
        ),
        titleSize: 18,
        titleFont: font600,
        amountFont: font600,
      ),

      ///
      /// RESERVE
      ///
      buildTableRow(
        title: 'Pričuva',
        amount: formatMoney(
          invoice.fees.reserve,
        ),
        titleSize: 18,
        titleFont: font600,
        amountFont: font600,
      ),

      ///
      /// DIVIDER
      ///
      SizedBox(height: 16),
      buildDivider(),
      SizedBox(height: 14),

      ///
      /// TOTAL
      ///
      buildTotalRow(
        title: 'Ukupno',
        amount: formatMoney(
          calculateInvoice() ?? 0,
        ),
      ),
    ],
  );
}
