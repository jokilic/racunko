import 'package:pdf/widgets.dart';

class PdfConsumption extends StatelessWidget {
  final String title;
  final double oldValue;
  final double newValue;
  final double price;
  final double totalPrice;
  final Widget? icon;
  final Font font400;
  final Font font600;
  final Font font700;

  PdfConsumption({
    required this.title,
    required this.oldValue,
    required this.newValue,
    required this.price,
    required this.totalPrice,
    required this.font400,
    required this.font600,
    required this.font700,
    this.icon,
  });

  @override
  Widget build(Context context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    font: font700,
                    fontSize: 22,
                  ),
                ),
              ),
              if (icon != null) ...[
                SizedBox(width: 8),
                icon!,
              ],
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  oldValue.toInt().toString(),
                  style: TextStyle(
                    font: font400,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  newValue.toInt().toString(),
                  style: TextStyle(
                    font: font400,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  price.toStringAsFixed(2),
                  style: TextStyle(
                    font: font400,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '${totalPrice.toStringAsFixed(2)}€',
                  style: TextStyle(
                    font: font600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      );
}
